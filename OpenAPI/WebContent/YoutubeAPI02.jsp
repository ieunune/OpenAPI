<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript">
	function handleAPILoaded() {
		$('#search-button').attr('disabled', false);
	}

	// Search for a specified string.
	function search() {
		var q = $('#query').val();
		var request = gapi.client.youtube.search.list({
			q : q,
			part : 'snippet'
		});

		request.execute(function(response) {
			var str = JSON.stringify(response.result);
			$('#search-container').html('<pre>' + str + '</pre>');
		});
	}
</script>
</head>
<body>

	<div id="buttons">
		<label> <input id="query" value='cats' type="text" />
			<button id="search-button" onclick="search()">Search</button></label>
	</div>
	<div id="search-container"></div>
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="auth.js"></script>
	<script src="search.js"></script>
	<script
		src="https://apis.google.com/js/client.js?onload=googleApiClientReady"></script>
</body>

</body>
</html>