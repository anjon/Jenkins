def course_progres(total_time, completed):
    progres = (completed / total_time) * 100
    print(f'You have completed {progres:.2f}% of the course.') 

total_course_time = 10.5 * 60
so_far_covered = 1.46 * 60 + 2.3 * 60 + 2.11 * 60 + 55

course_progres(total_course_time, so_far_covered)
