<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>Insert title here</title>
</head>
<body>
	<!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
	<b>div 태그 </b>
	<br>
	
	<div id="player"></div>
	
	<hr> 
	
	<b>iframe 태그 </b>
	<br>
	<iframe id="player" type="text/html" width="640" height="360"
		src="http://www.youtube.com/embed/M7lc1UVf-VE?enablejsapi=1&origin=http://example.com"
		frameborder="0"></iframe>
		
	<script>
		// 2. This code loads the IFrame Player API code asynchronously.
		var tag = document.createElement('script');

		//tag.src = "https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key=AIzaSyCLfw-LnOPD1_jqA1MuSEplfgUlIl8I4jY&part=snippet,contentDetails,statistics,status";
		tag.src="http://www.youtube.com/embed/M7lc1UVf-VE?enablejsapi=1&origin=http://example.com"
		var firstScriptTag = document.getElementsByTagName('script')[0];
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

		// 3. This function creates an <iframe> (and YouTube player)
		//    after the API code downloads.
		var player;
		function onYouTubeIframeAPIReady() {
			player = new YT.Player('player', {
				height : '360',
				width : '640',
				videoId : 'M7lc1UVf-VE',
				events : {
					'onReady' : onPlayerReady,
					'onStateChange' : onPlayerStateChange
				}
			});
		}

		// 4. The API will call this function when the video player is ready.
		function onPlayerReady(event) {
			event.target.playVideo();
		}

		// 5. The API calls this function when the player's state changes.
		//    The function indicates that when playing a video (state=1),
		//    the player should play for six seconds and then stop.
		var done = false;
		function onPlayerStateChange(event) {
			if (event.data == YT.PlayerState.PLAYING && !done) {
				setTimeout(stopVideo, 6000);
				done = true;
			}
		}
		function stopVideo() {
			player.stopVideo();
		}
	</script>
</body>
</html>