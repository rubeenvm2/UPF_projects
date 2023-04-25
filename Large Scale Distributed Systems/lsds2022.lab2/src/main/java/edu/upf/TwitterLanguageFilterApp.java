package edu.upf;

import edu.upf.model.*;

import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.SparkConf;

import java.util.Optional;

public class TwitterLanguageFilterApp {

    public static void main(String[] args){
        Long start = System.currentTimeMillis();

        String input = args[0];
        String lang = args[1];
        String outputDir = args[2];
        
        //Create a SparkContext to initialize
        SparkConf conf = new SparkConf().setAppName("Twitter Filter");
        JavaSparkContext sparkContext = new JavaSparkContext(conf);

        //Load the Twitter data into a Spark DataFrame
        JavaRDD<String> tweets_df = sparkContext.textFile(input);

        JavaRDD<SimplifiedTweet> tweetsWithLanguages = tweets_df
            .map(SimplifiedTweet::fromJson)
            .filter(Optional::isPresent)
            .map(Optional::get)
            .filter(t -> t.getLanguage().equals(lang));
        tweetsWithLanguages.saveAsTextFile(outputDir);

        sparkContext.close();
        Long end = System.currentTimeMillis();
        Long time = (end - start) / 1000;
        System.out.println(time + " seconds.");
    }
}

