package edu.upf.spark;

import edu.upf.model.*;
import scala.Tuple2;

import org.apache.spark.api.java.JavaSparkContext;

import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.SparkConf;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

public class BiGramsApp {

    public static void main(String[] args){
        String input = args[0];
        String lang = args[1];
        String outputDir = args[2];
        
        //Create a SparkContext to initialize
        SparkConf conf = new SparkConf().setAppName("Twitter Filter");
        JavaSparkContext sparkContext = new JavaSparkContext(conf);

        //Load the Twitter data into a Spark DataFrame
        JavaRDD<String> tweets_df = sparkContext.textFile(input);

        JavaRDD<ExtendedSimplifiedTweet> tweetsWithLanguages = tweets_df
            .map(ExtendedSimplifiedTweet::fromJson)
            .filter(Optional::isPresent)
            .map(Optional::get)
            .filter(t -> t.getisRetweeted()==false)
            .filter(t -> t.getLanguage().equals(lang));
        
        JavaRDD<String> words = tweetsWithLanguages
            .map(ExtendedSimplifiedTweet::getText)
            .flatMap(t -> Arrays.asList(t.split(" ")).iterator())
            .map(word -> normalise(word))
            .filter(item -> !item.isEmpty())                   
            ;   

        List<String> words1 = words.collect();
        List<String> bigrams = new ArrayList<>();
        for(int i = 0; i < words1.size()-1; i++){
            bigrams.add(words1.get(i)+ " "+ words1.get(i+1));
        }
        JavaRDD<String> test = sparkContext.parallelize(bigrams);
        JavaPairRDD<String, Integer>top_bigrams = test
            .mapToPair(bigram -> new Tuple2<>(bigram, 1))
            .reduceByKey((a,b) -> a + b)
            .mapToPair(Tuple2::swap)
            .sortByKey(false)
            .mapToPair(Tuple2::swap)
            ;

        top_bigrams.saveAsTextFile(outputDir);

        sparkContext.close();
    }
    private static String normalise(String word) {
        return word.trim().toLowerCase();
    }
}