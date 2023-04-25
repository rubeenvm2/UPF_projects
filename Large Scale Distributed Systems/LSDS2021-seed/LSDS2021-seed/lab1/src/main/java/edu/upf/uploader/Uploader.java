package edu.upf.uploader;

import java.io.IOException;
import java.util.List;

public interface Uploader {

    /**
     * Uploads a list of files to the target specified through its implementation
     * @param files the files to upload
     */
    void upload(List<String> files) throws IOException;
}
