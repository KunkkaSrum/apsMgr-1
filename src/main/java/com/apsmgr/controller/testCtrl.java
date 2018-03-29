package com.apsmgr.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("/test")
public class testCtrl {

    @GetMapping()
    public String test() {
        return "dfasfas";
    }
}
