package com.klef.jfsd.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.Admin1;
import com.klef.jfsd.springboot.model.Faculty;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.repository.Adminrepository;
import com.klef.jfsd.springboot.repository.FacultyRepository;
import com.klef.jfsd.springboot.repository.StudentRepository;

@Service
public class AdminServiceImp1 implements Adminservice
{
	@Autowired
	private StudentRepository studentRepository;
	
	@Autowired
	private Adminrepository adminrepository;
	
	@Autowired
	private FacultyRepository facultyRepository;
	
	@Override
	public Admin1 checkAdminLogin(String uname, String pwd) 
	{
		return adminrepository.checkAdminLogin(uname, pwd); 
	}

	@Override
	public List<Student> viewAllStudents() {
		return studentRepository.findAll();
	}
	@Override
	public String FacultyRegistration(Faculty faculty) {
		facultyRepository.save(faculty);
		return "Faculty Registered Successfully";
	}
	@Override
	public Faculty checkFacultyLogin(String email, String password) {
		return facultyRepository.checkFacultyLogin(email, password);
	}

	@Override
	public Student displayStudentById(int id) {
		return studentRepository.findById(id).get();
	}
	
	public Faculty validateFaculty(String username, String password) {
        return facultyRepository.findByemailAndPassword(username, password);
    }
}
