package com.klef.jfsd.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.Assignment;
import com.klef.jfsd.springboot.repository.AssignmentRepository;

@Service
public class AssignmentService {
    @Autowired
    private AssignmentRepository submissionRepository;

    public Assignment submitAssignment(Assignment submission) {
        return submissionRepository.save(submission);
    }

    public Assignment gradeAssignment(Long id, int marks) {
    	Assignment submission = submissionRepository.findById(id).orElseThrow(() -> new RuntimeException("Assignment not found"));
        submission.setGrade(marks);
        submission.setSubmitted(true);
        return submissionRepository.save(submission);
    }

    public List<Assignment> getSubmissionsByStudent(String studentId) {
        return submissionRepository.findByStudentId(studentId);
    }
    
}
