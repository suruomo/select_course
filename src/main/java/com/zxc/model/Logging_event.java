package com.zxc.model;

import java.io.File;

public class Logging_event {
    private int timestmp;
    private String formatted_message;
    private String logger_name;
    private String level_string;
    private String thread_name;
    private String caller_filename;
    private String caller_class;
    private String caller_method;
    private String caller_line;
    private int event_id;
	public int getTimestmp() {
		return timestmp;
	}
	public void setTimestmp(int timestmp) {
		this.timestmp = timestmp;
	}
	public String getFormatted_message() {
		return formatted_message;
	}
	public void setFormatted_message(String formatted_message) {
		this.formatted_message = formatted_message;
	}
	public String getLogger_name() {
		return logger_name;
	}
	public void setLogger_name(String logger_name) {
		this.logger_name = logger_name;
	}
	public String getLevel_string() {
		return level_string;
	}
	public void setLevel_string(String level_string) {
		this.level_string = level_string;
	}
	public String getThread_name() {
		return thread_name;
	}
	public void setThread_name(String thread_name) {
		this.thread_name = thread_name;
	}
	public String getCaller_filename() {
		return caller_filename;
	}
	public void setCaller_filename(String caller_filename) {
		this.caller_filename = caller_filename;
	}
	public String getCaller_class() {
		return caller_class;
	}
	public void setCaller_class(String caller_class) {
		this.caller_class = caller_class;
	}
	public String getCaller_method() {
		return caller_method;
	}
	public void setCaller_method(String caller_method) {
		this.caller_method = caller_method;
	}
	public String getCaller_line() {
		return caller_line;
	}
	public void setCaller_line(String caller_line) {
		this.caller_line = caller_line;
	}
	public int getEvent_id() {
		return event_id;
	}
	public void setEvent_id(int event_id) {
		this.event_id = event_id;
	}
    
}
