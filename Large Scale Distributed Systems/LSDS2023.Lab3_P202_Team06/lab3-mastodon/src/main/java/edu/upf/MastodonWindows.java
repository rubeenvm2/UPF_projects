package edu.upf;

import com.github.tukaaa.MastodonDStream;
import com.github.tukaaa.config.AppConfig;
import com.github.tukaaa.model.SimplifiedTweetWithHashtags;

import edu.upf.util.LanguageMapUtils;
import scala.Tuple2;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.streaming.Durations;
import org.apache.spark.streaming.StreamingContext;
import org.apache.spark.streaming.api.java.JavaDStream;
import org.apache.spark.streaming.api.java.JavaPairDStream;
import org.apache.spark.streaming.api.java.JavaStreamingContext;

public class MastodonWindows {
    public static void main(String[] args) {
        String input = args[0];

        SparkConf conf = new SparkConf().setAppName("Real-time Mastodon Stateful with Windows Exercise");
        AppConfig appConfig = AppConfig.getConfig();

        StreamingContext sc = new StreamingContext(conf, Durations.seconds(20));
        JavaStreamingContext jsc = new JavaStreamingContext(sc);
        jsc.checkpoint("/tmp/checkpoint");

        JavaDStream<SimplifiedTweetWithHashtags> stream = new MastodonDStream(sc, appConfig).asJStream();

        // TODO IMPLEMENT ME
        final JavaRDD<String> languageMapLines = jsc.sparkContext().textFile(input);
        final JavaPairRDD<String, String> languageMap = LanguageMapUtils.buildLanguageMap(languageMapLines);
        
        final JavaPairDStream<String, Integer> languageCountStream = stream
            .mapToPair(tweet -> new Tuple2<>(tweet.getLanguage(), tweet.getTweetId()))
            .transformToPair(rdd -> rdd.join(languageMap).distinct())
            .map(tweet-> tweet._2) 
            .map(Tuple2::swap)
            .mapToPair(status -> new Tuple2<>(status._1(), 1))
            .reduceByKey((count1, count2) -> count1 + count2); 
        final JavaPairDStream<Integer, String> languageBatch = languageCountStream 
            .mapToPair(Tuple2::swap)
            .transformToPair(rdd-> rdd.sortByKey(false));

        final JavaDStream<SimplifiedTweetWithHashtags> windowedStream = stream.window(Durations.seconds(20));
        final JavaPairDStream<Integer, String> languageWindow = windowedStream
            .mapToPair(tweet -> new Tuple2<>(tweet.getLanguage(), tweet.getTweetId()))
            .transformToPair(rdd -> rdd.join(languageMap).distinct())
            .map(tweet-> tweet._2) 
            .map(Tuple2::swap)
            .mapToPair(status -> new Tuple2<>(status._1(), 1))
            .reduceByKey((count1, count2) -> count1 + count2)
            .mapToPair(Tuple2::swap)
            .transformToPair(rdd-> rdd.sortByKey(false));
        
        languageBatch.print(15);
        languageWindow.print(15);
        
        // Start the application and wait for termination signal
        sc.start();
        sc.awaitTermination();
        jsc.close();
    }

}
