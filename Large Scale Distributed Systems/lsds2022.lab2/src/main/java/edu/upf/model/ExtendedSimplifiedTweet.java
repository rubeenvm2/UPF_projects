package edu.upf.model;

import java.io.Serializable;
import java.util.Optional;


import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
public class ExtendedSimplifiedTweet implements Serializable {

  private static JsonParser parser = new JsonParser();

  private final Long tweetId; // the id of the tweet (’id’)
  private final String text; // the content of the tweet (’text’)
  private final Long userId; // the user id (’user->id’)
  private final String userName; // the user name (’user’->’name’)
  private final Long followersCount; // the number of followers (’user’->’followers_count’)
  private final String language; // the language of a tweet (’lang’)
  private final boolean isRetweeted; // is it a retweet? (the object ’retweeted_status’ exists?)
  private final Long retweetedUserId; // [if retweeted] (’retweeted_status’->’user’->’id’)
  private final Long retweetedTweetId; // [if retweeted] (’retweeted_status’->’id’)
  private final Long timestampMs; // seconds from epoch (’timestamp_ms’)

  public ExtendedSimplifiedTweet(Long tweetId, String text, Long userId, String userName, Long followersCount, String language, boolean isRetweeted, Long retweetedUserId, Long retweetedTweetId, Long timestampMs) {

    this.tweetId = tweetId;
    this.text = text;
    this.userId = userId;
    this.userName = userName;
    this.followersCount = followersCount;
    this.language = language;
    this.isRetweeted = isRetweeted;
    this.retweetedUserId = retweetedUserId;
    this.retweetedTweetId = retweetedTweetId;
    this.timestampMs = timestampMs;

  }

  /**
  * Returns a {@link ExtendedSimplifiedTweet} from a JSON String.
  * If parsing fails, for any reason, return an {@link Optional#empty()}
  *
  * @param jsonStr
  * @return an {@link Optional} of a {@link ExtendedSimplifiedTweet}
  */
  public static Optional<ExtendedSimplifiedTweet> fromJson(String jsonStr) {
  // IMPLEMENT ME
    Long tweetId = null;
    String text = null;
    Long userId = null;
    String userName = null;
    Long followersCount = null;
    String language = null;
    Boolean isRetweeted = false;
    Long rt_userId = null;
    Long rt_tweetId = null;
    Long timestampMs = null;

    if (jsonStr.equals("") == false){
      JsonElement je = parser.parse(jsonStr);
      JsonObject jo = je.getAsJsonObject();

      if(jo.has("id")){
        tweetId = jo.get("id").getAsLong();
      }
      
      if(jo.has("text")){
        text = jo.get("text").getAsString();
      }

      if(jo.has("user")){
        JsonObject userObj = (jo.get("user")).getAsJsonObject();
        if(userObj.has("name")){
          userName = userObj.get("name").getAsString();
        }
        if(userObj.has("id")){
          userId = userObj.get("id").getAsLong();
        }
        if(userObj.has("followers_count")){
          followersCount = userObj.get("followers_count").getAsLong();
        }
      }

      if(jo.has("lang")){
        language = jo.get("lang").getAsString();
      }

      if(jo.has("retweeted_status")){
        isRetweeted = true;
        JsonObject rtObj = (jo.get("retweeted_status")).getAsJsonObject();
        if(rtObj.has("user")){
          JsonObject rt_userObj = (jo.get("user")).getAsJsonObject();
          rt_userId = rt_userObj.get("id").getAsLong();
        }
        rt_tweetId = rtObj.get("id").getAsLong();
      }

      if(jo.has("timestamp_ms")){
        timestampMs = jo.get("timestamp_ms").getAsLong();
      }

      if ((tweetId != null) && (text != null) && (userId != null) &&  (userName != null) && (followersCount != null) && (language != null) &&  (timestampMs != null)){
        ExtendedSimplifiedTweet extendedsimplifiedtweet = new ExtendedSimplifiedTweet(tweetId, text, userId, userName, followersCount, language, isRetweeted, rt_userId, rt_tweetId, timestampMs);
        return Optional.of(extendedsimplifiedtweet);
      }
      else{
        return Optional.empty();
      }
    } else{
      return Optional.empty();
    }
  }

  public String getLanguage() {
    return language;
  }
  public String getText() {
    return text;
  }
  public Long getFollowersCount() {
    return followersCount;
  }
  public Long getRetweetedTweetId() {
    return retweetedTweetId;
  }
  public Long getRetweetedUserId() {
    return retweetedUserId;
  }
  public Long getTimestampMs() {
    return timestampMs;
  }
  public Long getTweetId() {
    return tweetId;
  }
  public Long getUserId() {
    return userId;
  }
  public String getUserName() {
    return userName;
  }
  public Boolean getisRetweeted(){
    return isRetweeted;
  }
}
