package com.klef.jfsd.springboot.service;

import com.klef.jfsd.springboot.model.Faculty;

public interface FacultyService 
{

	Faculty validateFaculty(String username, String password);
}
