package com.klef.jfsd.springboot.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.klef.jfsd.springboot.model.Assignment;
import com.klef.jfsd.springboot.repository.AssignmentRepository;

@RestController
@RequestMapping("/api/assignments")
public class AssignmentController {
    
    @Autowired
    private AssignmentRepository assignmentRepository;

    // Define the upload directory path (absolute path)
    private final String uploadDir = "C:/uploads/";

    @PostMapping("/submit")
    public ResponseEntity<String> submitAssignment(@RequestParam("assignmentId") Long assignmentId,
                                                   @RequestParam("studentId") String studentId,
                                                   @RequestParam("file") MultipartFile file) throws IOException {

        // Ensure the upload directory exists, if not, create it
        Path path = Paths.get(uploadDir);
        if (!Files.exists(path)) {
            Files.createDirectories(path);
        }

        // Save the uploaded file with the original filename
        String filePath = uploadDir + file.getOriginalFilename();
        file.transferTo(new File(filePath));

        // Update the assignment status in the database
        Assignment assignment = assignmentRepository.findById(assignmentId)
                .orElseThrow(() -> new RuntimeException("Assignment not found"));

        assignment.setSubmitted(true);
        assignmentRepository.save(assignment);

        return ResponseEntity.ok("Assignment submitted successfully!");
    }

    @PostMapping("/grade")
    public ResponseEntity<String> gradeAssignment(@RequestParam("assignmentId") Long assignmentId,
                                                  @RequestParam("grade") int grade) {
        Assignment assignment = assignmentRepository.findById(assignmentId)
                .orElseThrow(() -> new RuntimeException("Assignment not found"));

        assignment.setGrade(grade);
        assignmentRepository.save(assignment);

        return ResponseEntity.ok("Assignment graded successfully!");
    }

    @GetMapping("/{id}")
    public ResponseEntity<Assignment> getAssignmentById(@PathVariable("id") Long id) {
        Assignment assignment = assignmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Assignment not found"));

        return ResponseEntity.ok(assignment);
    }
}
