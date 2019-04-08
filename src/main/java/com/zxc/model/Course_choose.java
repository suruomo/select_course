package com.zxc.model;

//选课表
public class Course_choose {
    private int chooseId;
    private int stuId;   //学生id
    private int classId;  //课程id
    private int score;   //成绩

    public void setStuId(int stuId) {
        this.stuId = stuId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public void setChooseId(int chooseId) {
        this.chooseId = chooseId;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getStuId() {
        return stuId;
    }

    public int getClassId() {
        return classId;
    }

    public int getChooseId() {
        return chooseId;
    }

    public int getScore() {
        return score;
    }
}
