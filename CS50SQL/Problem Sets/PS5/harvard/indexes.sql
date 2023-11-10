CREATE INDEX "enrollment_sid_cid_index" ON "enrollments" ("student_id", "course_id");

CREATE INDEX "enrollmentcourse_cid_index" ON "enrollments" ("course_id");
CREATE INDEX "courses_id_dept_num_sem_index" ON "courses" ("id", "department","number", "semester");

CREATE INDEX "courses_sem_index" ON "courses" ("semester");

CREATE INDEX "satisfies_cid_index" ON "satisfies" ("course_id");
CREATE INDEX "courses_ttl_sem_index" ON "courses" ("title", "semester");

CREATE INDEX "students_name_index" ON "students" ("name");
