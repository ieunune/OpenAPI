<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>

<script type="text/javascript">
	
	var cnt = 5;	

	function fnGetList(sGetToken){
		
//		console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+sGetToken);
// 		var $getval = $("#search_box").val();
		
// 		if($getval == ""){
// 			alert("검색어 입력 !");
// 			$("#search_box").focus();
// 			return;
// 		}
				
		$("#get_view").empty();
		$("#nav_view").empty();
		//
		
		
		var sTargetUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&order=relevance"
				+ "&q=" + encodeURIComponent("메이플") + "&key=AIzaSyDp2Rg4rgoTVN4mB33-zyPZgl1GjIpYt1w";
		
		console.log(sTargetUrl);
		
		if(sGetToken){
// 			sTargetUrl += "&pageToken=" + sGetToken;
			cnt += 5 ;
			console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+ cnt);
			sTargetUrl += "&maxResults="+cnt;
		}
		
					
					var test = "https://www.googleapis.com/youtube/v3/videos?part=statistics&id="+this.id.videoId+"&key=AIzaSyDp2Rg4rgoTVN4mB33-zyPZgl1GjIpYt1w";
					console.log(test);
					$.ajax({
						
						type : "POST",
						url : test,
						dataType : "jsonp",
						success : function(jdata) {
							
							console.log(jdata);
							
							$(jdata.items).each(function(i){
								$("#get_view").append(this.statistics.viewCount+"<br>");
								$("#get_view").append(this.statistics.likeCount+"<br>");
								$("#get_view").append(this.statistics.dislikeCount+"<br>");
								$("#get_view").append(this.statistics.favoriteCount+"<br>");
								$("#get_view").append(this.statistics.commentCount+"<br>");
							});
							
							$.ajax({
								
								type : "POST",
								url : sTargetUrl,
								dataType : "jsonp",
								success : function(jdata) {
									
									console.log(jdata);
									
									$(jdata.items).each(function(i){
										
										console.log(" 비디오 아이디 : " + this.id.videoId) ;
										console.log(" sinppet.title : " + this.snippet.title) ; 
										console.log(" sinppet.description : " + this.snippet.description) ; 
										console.log(" sinppet.thumbnail : " + this.snippet.thumbnails.default.url);
										
										$("#get_view").append("<iframe width='900' height='500' src='https://www.youtube.com/embed/"+this.id.videoId+"'></iframe>");
										$("#get_view").append("<span class='box'>"); //<img src='"+this.snippet.thumbnails.default.url+"'>
										$("#get_view").append("<a href=http://youtu.be/"+this.id.videoId+" "+"target='_blank'>" + "<br><span class='title'>"+this.snippet.title+"</span></a><br>");
										
										$("#get_view").append(this.snippet.publishedAt+"<br>");
										$("#get_view").append("<span class='description'><br>"+this.snippet.description+"</span><br><span class='channelTitle'>"+this.snippet.channelTitle+"</span></span><br><p>");
									});
								}
							}).promise().done(function(){
								
//			 					if(jdata.prevPageToken){
//			 						$("#nav_view").append("<button class='paging' onclick='javascript:fnGetList(\""+jdata.prevPageToken+"\");'> < </button>");
//			 					}
								
								if(jdata.nextPageToken){
									$("#nav_view").append("<button class='paging' onclick='javascript:fnGetList(\""+jdata.nextPageToken+"\");'> 더 보기 </button>");
								}
							});
							
						}					
					});			
	}
</script>

<style type="text/css">
img {
	width: 100px;
	height: 100px;
}

span {
	max-width: 900px;
	/* 	background-color: green; */
	display: inline-block;
}

body {
	padding-top: 100px;
}

.box {
	/* 	background-color: red; */
	min-width: 50%;
	max-width: 50%;
	/* 	min-height: 500px; */
	/* 	max-height: 500px; */

	/* 	margin-top : 1px; */
	/* 	margin-bottom : 1px; */
	/* 	padding-bottom: 1px; */
}

#get_view {
	float: left;
}

.paging {
	width: 100%;
	height: 50px;
	background-color: black;
	color: white;
}

.title {
	font-size: 18px;
}

.description {
	font-size: 14px;
}

.channelTitle {
	font-size: 14px;
	font-weight: bold;
}
</style>
</head>
<body onload="fnGetList();">

	<!-- 	<form name="form1" method="post" onsubmit="return false;"> -->
	<!-- 		<input type="text" id="search_box" /> -->
	<!-- 		<button onClick="fnGetList();">가져오기</button> -->
	<!-- 	</form> -->
	<button>메이플</button>
	<button>애견상식</button>
	<button>동물들이 좋아하는 소리</button>

	<hr>
	<div id="get_view"></div>
	<div id="nav_view"></div>

</body>
</html>