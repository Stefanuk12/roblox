#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include "curl/curl.h"
#include <jsoncons/json.hpp>
#include <cassert>

using namespace jsoncons;

size_t WriteCallback(char *contents, size_t size, size_t nmemb, void *userp){
    ((std::string*)userp)->append((char*)contents, size * nmemb);
    return size * nmemb;
}

bool checkMusic(std::string SoundId){
    std::string url = "https://www.roblox.com/library/" + SoundId;
    std::vector<std::string> removedAssets = {
        "70608418c648be7ac4e323e3294bb059",
        "d28c1b5eed271a7aa76f16689e74ca04",
    };

    curl_global_init(CURL_GLOBAL_ALL);
    CURL* easyhandle = curl_easy_init();
    std::string readBuffer;
    curl_easy_setopt(easyhandle, CURLOPT_URL, url);
    curl_easy_setopt(easyhandle, CURLOPT_VERBOSE, 1L);
    curl_easy_setopt(easyhandle, CURLOPT_PROXYPORT, 8080L);
    curl_easy_setopt(easyhandle, CURLOPT_WRITEFUNCTION, WriteCallback);
    curl_easy_setopt(easyhandle, CURLOPT_WRITEDATA, &readBuffer);
    curl_easy_perform(easyhandle);

    for (std::string v : removedAssets){
        if (readBuffer.find(v)){
            return false;
        };
    };

    return true;
};

int main(){
    /*
    std::ifstream target("./MusicTable.json");
    jsoncons::json jsondata = jsoncons::json::parse(target);
    
    for (int i = 0; i < jsondata.capacity(); ++i){
        if ( jsondata[i].contains("Name") ){
            jsoncons::json item = jsondata[i];
            std::string Name = item["Name"].as<std::string>();
            std::string SoundId = item["SoundId"].as<std::string>();

            if ( !checkMusic(SoundId) && jsondata[i].is_object() ){
                jsondata.remove_range(i, i);
                std::cout << "Removed: " << Name << " - " << SoundId << "\n";
            };
            
            std::cout << jsondata << "\n";
        };
    }
    */

    std::string SoundId = "55435453";
    std::cout << checkMusic(SoundId) << "\n";
    
    return 0;
};