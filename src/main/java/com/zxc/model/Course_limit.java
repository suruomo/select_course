package com.zxc.model;

//选课学院限制
public class Course_limit {
    private int classId;   //课程id
    private int insId;   //学院id

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public void setInsId(int insId) {
        this.insId = insId;
    }

    public int getClassId() {
        return classId;
    }

    public int getInsId() {
        return insId;
    }
}
