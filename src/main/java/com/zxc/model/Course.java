package com.zxc.model;

import java.util.List;

public class Course {
    private int classId;   //课程id
    private String className;   //课程名称
    private int classNum;   //课程容量
    private int teaId;   //授课教师id
    private String teaName;    //授课教师名称
    private int classChooseNum;   //课程所选数量
    private String score;    //成绩
    private int isChoose;   //是否选择
    private String type;   //课程类型
    private String credit;   //课程学分
    private String introduction;   //课程简介
    private String year;   //开课学年
    private String term;   //开课学期
    private String classify;  //课程类别
    private List<String> classLimitProName;  //课程限制专业名称
    private String item;   //体育项目
    private String ins;//开课学院
	public String getIns() {
		return ins;
	}
	public void setIns(String ins) {
		this.ins = ins;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public int getClassId() {
		return classId;
	}
	public void setClassId(int classId) {
		this.classId = classId;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public int getClassNum() {
		return classNum;
	}
	public void setClassNum(int classNum) {
		this.classNum = classNum;
	}
	public int getTeaId() {
		return teaId;
	}
	public void setTeaId(int teaId) {
		this.teaId = teaId;
	}
	public String getTeaName() {
		return teaName;
	}
	public void setTeaName(String teaName) {
		this.teaName = teaName;
	}
	public int getClassChooseNum() {
		return classChooseNum;
	}
	public void setClassChooseNum(int classChooseNum) {
		this.classChooseNum = classChooseNum;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String string) {
		this.score = string;
	}
	public int getIsChoose() {
		return isChoose;
	}
	public void setIsChoose(int isChoose) {
		this.isChoose = isChoose;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCredit() {
		return credit;
	}
	public void setCredit(String credit) {
		this.credit = credit;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getTerm() {
		return term;
	}
	public void setTerm(String term) {
		this.term = term;
	}
	public String getClassify() {
		return classify;
	}
	public void setClassify(String classify) {
		this.classify = classify;
	}
	public List<String> getClassLimitProName() {
		return classLimitProName;
	}
	public void setClassLimitProName(List<String> classLimitProName) {
		this.classLimitProName = classLimitProName;
	}
	
}

