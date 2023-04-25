package edu.upf;

import scala.Tuple2;

import com.github.tukaaa.MastodonDStream;
import com.github.tukaaa.config.AppConfig;
import com.github.tukaaa.model.SimplifiedTweetWithHashtags;

import org.apache.spark.SparkConf;
import org.apache.spark.streaming.Durations;
import org.apache.spark.streaming.StreamingContext;
import org.apache.spark.streaming.api.java.JavaDStream;
import org.apache.spark.streaming.api.java.JavaPairDStream;
import org.apache.spark.streaming.api.java.JavaStreamingContext;

public class MastodonWithState {
    public static void main(String[] args) throws InterruptedException {
        SparkConf conf = new SparkConf().setAppName("Real-time Mastodon With State");
        AppConfig appConfig = AppConfig.getConfig();

        StreamingContext sc = new StreamingContext(conf, Durations.seconds(30));
        JavaStreamingContext jsc = new JavaStreamingContext(sc);
        jsc.checkpoint("/tmp/checkpoint");

        JavaDStream<SimplifiedTweetWithHashtags> stream = new MastodonDStream(sc, appConfig).asJStream();

        // TODO IMPLEMENT ME
        String language = args[1];

        final JavaPairDStream<String, Integer> tweetPerUser = stream
            .filter(tweet -> tweet.getLanguage() != null)
            .filter(tweet -> tweet.getLanguage().equals(language))   
            .mapToPair(tweet -> new Tuple2<>(tweet.getUserName(), 1))
            .reduceByKey((count1, count2) -> count1 + count2);
        
        final JavaPairDStream<Integer, String> tweetsCountPerUser = tweetPerUser
            .mapToPair(Tuple2::swap)
            .transformToPair(rdd -> rdd.sortByKey(false)); 

        tweetsCountPerUser.print(20);

        // Start the application and wait for termination signal
        jsc.start();
        jsc.awaitTermination();
        jsc.close();
    }

}
