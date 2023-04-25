package edu.upf.spark;

import edu.upf.model.*;
import scala.Tuple2;

import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.SparkConf;

import java.util.List;
import java.util.Optional;

public class MostRetweetedApp {

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
            .filter(t -> t.getisRetweeted()==true)
            .filter(t -> t.getLanguage().equals(lang));
        
        JavaRDD<Long> rt_id = tweetsWithLanguages
            .map(ExtendedSimplifiedTweet::getRetweetedUserId)
            .mapToPair(id -> new Tuple2<>(id, 1))
            .reduceByKey((a, b) -> a + b)
            .mapToPair(Tuple2::swap)
            .sortByKey(false)
            .map(Tuple2::_2);
        
        List<Long> top10Users = rt_id
            .take(10);
        System.out.println("\n"+"\n"+top10Users+"\n\n");

        JavaPairRDD<Long, Object> final_tweets = tweetsWithLanguages
            .filter(t -> top10Users.contains(t.getRetweetedUserId()))
            .mapToPair(s -> new Tuple2<>(s.getRetweetedUserId(), new Tuple2<>(s.getRetweetedTweetId(),1)))
            .reduceByKey((a, b) -> new Tuple2<>(a._1, a._2 + b._2))
            .mapValues(v -> v._1)
            ;

        final_tweets.saveAsTextFile(outputDir);        

        sparkContext.close();
    }

}