package edu.upf.parser;

import java.util.Optional;


import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class SimplifiedTweet {

  // All classes use the same instance
  private static JsonParser parser = new JsonParser();



  private final Long tweetId;			  // the id of the tweet ('id')
  private final String text;  		      // the content of the tweet ('text')
  private final Long userId;			  // the user id ('user->id')
  private final String userName;		  // the user name ('user'->'name')
  private final String language;          // the language of a tweet ('lang')
  private final Long timestampMs;		  // seconduserIds from epoch ('timestamp_ms')

  public SimplifiedTweet(Long tweetId, String text, Long userId, String userName,
                         String language, Long timestampMs) {

    this.tweetId = tweetId;
    this.text = text;
    this.userId = userId;
    this.userName = userName;
    this.language = language;
    this.timestampMs = timestampMs;
  }

  /**
   * Returns a {@link SimplifiedTweet} from a JSON String.
   * If parsing fails, for any reason, return an {@link Optional#empty()}
   *
   * @param jsonStr
   * @return an {@link Optional} of a {@link SimplifiedTweet}
   */
  public static Optional<SimplifiedTweet> fromJson(String jsonStr) {
    
    Long tweetId = null;
    String text = null;
    Long userId = null;
    String userName = null;
    String language = null;
    Long timestampMs = null;

    if (jsonStr.equals("") == false){
      JsonElement je = JsonParser.parseString(jsonStr);
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
      }

      if(jo.has("lang")){
        language = jo.get("lang").getAsString();
      }

      if(jo.has("timestamp_ms")){
        timestampMs = jo.get("timestamp_ms").getAsLong();
      }

      if ((tweetId != null) && (text != null) && (userId != null) &&  (userName != null) && (language != null) && (timestampMs != null)){
        SimplifiedTweet simplifiedtweet = new SimplifiedTweet(tweetId, text, userId, userName, language, timestampMs);
        return Optional.of(simplifiedtweet);
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

  @Override
  public String toString() {
    return new Gson().toJson(this);
  }

}
