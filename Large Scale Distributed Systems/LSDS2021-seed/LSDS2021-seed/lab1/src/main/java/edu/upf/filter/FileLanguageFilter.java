package edu.upf.filter;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.Optional;

import edu.upf.parser.SimplifiedTweet;

import java.io.IOException;


public class FileLanguageFilter implements LanguageFilter{
    private final String inputFile;
    private final String outputFile;

    public FileLanguageFilter(String inputFile, String outputFile) {
        this.inputFile = inputFile;
        this.outputFile  = outputFile;
    }

    @Override
    public void filterLanguage(String language) throws IOException {
        try(FileReader reader = new FileReader(inputFile);
            BufferedReader bReader = new BufferedReader(reader);
            FileWriter writer = new FileWriter(outputFile);
            BufferedWriter bWriter = new BufferedWriter(writer);){

            String line = bReader.readLine(); 

            while((line =  bReader.readLine())!= null){
                Optional<SimplifiedTweet> tweet = SimplifiedTweet.fromJson(line);
                if(!tweet.isEmpty()){
                    if(tweet.get().getLanguage().equals(language)){
                        //tweet.get().getText(); en caso que queramos solo el texto
                        bWriter.write(tweet.toString());
                        bWriter.newLine();
                    }
                }
            }

            bWriter.flush();

            bReader.close();
            bWriter.close();

        }
    }
}
