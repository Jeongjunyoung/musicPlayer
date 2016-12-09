<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/../resources/js/jquery.min.js"></script>
<script src="/../resources/js/sweetalert.min.js"></script>
<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/../resources/css/sweetalert.css">
<script type="text/javascript">
$(function(){
	$('#btn').click(function(){
		swal("Success!!!", "Something went wrong!", "success");
	/* 	swal({
			  title: "Are you sure?",
			  text: "You will not be able to recover this imaginary file!",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#DD6B55",
			  confirmButtonText: "Yes, delete it!",
			  closeOnConfirm: false,
			  html: false
			}, function(){
			  swal("Deleted!",
			  "Your imaginary file has been deleted.",
			  "success");
			}); */
	})
})
</script>
</head>
<body>
	<button id="btn">클릭</button>
</body>
</html>