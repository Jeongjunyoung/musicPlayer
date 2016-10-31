<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- JavaSciprt File -->
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script type="text/javascript" src="/../resources/js/musicBox.js"></script>
<!-- CSS File -->
<link href="/../resources/css/musicBox.css" type="text/css" rel="stylesheet">
</head>
<body>
	<div id="player"></div>
	<div id="list" class="box">
		<img src="/../resources/images/play.png" onclick="playVideo()" id="playBtn">
		<img src="/../resources/images/pause.png" onclick="pauseVideo()" id="stopBtn">
		<img src="/../resources/images/shuffle.png" onclick="shufflePlay()" id="shuffleBtn">
		<ul id="playList" class="hoverList">
			<li value="y7gCktBEn5U">with coffee</li>
			<li value="-sVo6NWwK_o">벌써 일년</li>
			<li value="BTM68fJS1nM">Brown eyed girl</li>
		</ul>
	</div>
	<input id="searchKey" type="text"><button id="searchBtn">검색</button><button id="checkAdd">선택 추가</button>
	<div id="searchResult" class="box">
	</div>
</body>
</html>