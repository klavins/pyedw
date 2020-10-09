SELECT DISTINCT dept_code,RTRIM(dept_full_nm) AS Dept
FROM sec.Sr_dept_code d
INNER JOIN sec.Sr_major_code mc ON mc.major_dept = d.dept_code
	AND mc.major_last_yr * 10 + mc.major_last_qtr = (
		SELECT TOP 1 mc2.major_last_yr * 10 + mc2.major_last_qtr
		FROM sec.Sr_major_code mc2
		ORDER BY mc2.major_last_yr * 10 + mc2.major_last_qtr DESC
		)
WHERE d.dept_college IN (@College)
ORDER BY Dept