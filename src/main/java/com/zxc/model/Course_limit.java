package com.zxc.model;

//选课学院限制
public class Course_limit {
    private int classId;   //课程id
    private int proId;     //限制专业id
    public void setClassId(int classId) {
        this.classId = classId;
    }

    public int getClassId() {
        return classId;
    }

	public int getProId() {
		return proId;
	}
	public void setProId(int proId) {
		this.proId = proId;
	}
    
}
