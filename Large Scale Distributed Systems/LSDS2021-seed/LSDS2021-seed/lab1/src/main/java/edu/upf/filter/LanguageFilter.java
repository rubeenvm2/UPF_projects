package edu.upf.filter;
import java.io.IOException;

public interface LanguageFilter {

  /**
   * Process
   * @param language
   * @return
   */
  void filterLanguage(String language) throws IOException;
}
