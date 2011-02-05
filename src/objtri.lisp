(defun tokenize-line (delim line)
	(loop with l = (length delim)
				for n = 0 then (+ pos l)
				for pos = (search delim line :start2 n)
			if pos collect (subseq line n pos)
			else collect (subseq line n)
		while pos))
		
(defun untokenize-line (delim line)
	(loop with l = (length line)
				for n = 0 then (+ n 1)
			collect (nth n line)
			if (< n (- l 1)) collect delim
		while (/= n (- l 1))))

(defun triangulate (tokens out-stream)
	(write-line (concatenate 'string (nth 0 tokens) " " (nth 1 tokens) " " (nth 2 tokens) " " (nth 3 tokens) " ") out-stream)
	(write-line (concatenate 'string (nth 0 tokens) " " (nth 1 tokens) " " (nth 3 tokens) " " (nth 4 tokens) " ") out-stream))
	
(defun proc-line (str out-stream)
	(let ((tokens (tokenize-line " " (string-right-trim " " str))))
		(if (string= (first tokens) "f")
			(if (eq 5 (list-length tokens))
				(triangulate tokens out-stream)
				(write-line str out-stream))
			(write-line str out-stream))))

(defun obj-tri (filename)
	(with-open-file (in-stream filename :direction :input)
		(let ((new-path (format nil "~{~a~}" (untokenize-line "/" (concatenate 'list (butlast (tokenize-line "/" filename)) (list (format nil "tri_~{~a~}" (last (tokenize-line "/" filename)))))))))
				(with-open-file (out-stream new-path :direction :output :if-exists :supersede :if-does-not-exist :create)
					(do ((line (read-line in-stream nil)
								(read-line in-stream nil)))
							((null line))
						(proc-line line out-stream))))))

