package com.klef.jfsd.springboot.repository;
import com.klef.jfsd.springboot.model.*;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AssignmentRepository extends JpaRepository<Assignment, Long> {
//    List<Assignment> findByStudent(String studentId);
    List<Assignment> findByStudentId(String studentId); 
    List<Assignment> findBySubmittedTrueAndGradeNull();
    List<Assignment> findAll();
}

