<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>Insert title here</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.3.1.js"></script>

<style type="text/css">
body {
	background: #20262E;
	padding: 20px;
	font-family: Helvetica;
}

#banner-message {
	BACKGROUND: #FFF;
	BORDER-RADIUS: 4PX;
	PADDING: 20PX;
	FONT-SIZE: 25PX;
	TEXT-ALIGN: CENTER;
	TRANSITION: ALL 0.2S;
	MARGIN: 0 AUTO;
	WIDTH: 500PX;
}

#breed_data {
	background: #fff;
	border-radius: 4px;
	padding: 20px;
	font-size: 12px;
	text-align: left;
	transition: all 0.2s;
	margin: 0 auto;
	width: 500px;
}

#breed_image {
	background: #fff;
	margin: 0 auto;
	width: 500px;
	height: 500px;
}

.breed_select1 {
	COLOR: WHITE;
	WIDTH: 50%;
}
</style>
</head>
<body>

<!-- 	<div class="breed_select1"> -->
<!-- 		<span></span> -->
<!-- 	</div> -->


	<div id="banner-message">
		<p>품종선택</p>


		<select class="breed_select">
			<option></option>
		</select>

	</div>
	<div id="breed_data">
		<img id="breed_image" src="" />
		<p>품종 정보</p>
		<table id="breed_data_table">

		</table>	
	</div>

	<script type="text/javascript">
		var $breed_select = $('div.breed_select1');
		$breed_select.click(function() {
			//alert($(this).children().attr("id"));
// 			alert("1 : "+$(".breed_select1").children(this).attr("id"));
// 			alert("2 : "+$(this).parents().html());
// 			alert("3 : "+$(this).children(":clicked").attr("id"));
// 			alert("4 : "+$(this).text());
			//var id = $(this).children(":selected").attr("id");
			//alert(id);
			getDogByBreed(id);
		});

		var $breed_select = $('select.breed_select');
		$breed_select.change(function() {
			var id = $(this).children(":selected").attr("id");
			getDogByBreed(id);
		});

		function getBreeds() {
			ajax_get('https://api.thedogapi.com/v1/breeds', function(data) {
				populateBreedsSelect(data);
			});
		}

		function populateBreedsSelect(breeds) {
			$breed_select.empty().append(
					function() {
						var output = '';
						$.each(breeds, function(key, value) {

							if (value.name == 'Chow Chow') {
								value.name = '차우차우';
							}
							
// 							output += '<span id="' + value.id + '">'
// 							+ value.name + '</span><br>';
							
							
							output += '<option id="' + value.id + '">'
									+ value.name + '</option>';
						});
						return output;
					});
		}

		function getDogByBreed(breed_id) {
			ajax_get(
					'https://api.thedogapi.com/v1/images/search?include_breed=1&breed_id='
							+ breed_id,
					function(data) {

						if (data.length == 0) {
							clearBreed();
							$("#breed_data_table")
									.append(
											"<tr><td>아직 작성되어 있지 않은 품종 정보 입니다.</td></tr>");
						} else {
							displayBreed(data[0])
						}
					});
		}

		function clearBreed() {
			$('#breed_image').attr('src', "");
			$("#breed_data_table tr").remove();
		}

		function displayBreed(image) {
			$('#breed_image').attr('src', image.url);
			$("#breed_data_table tr").remove();

			var breed_data = image.breeds[0]
			$.each(breed_data, function(key, value) {
				if (key == 'weight' || key == 'height') {
					value = value.metric
				}

				if (key == 'weight') {
					key = '무게';
				}

				if (key == 'height') {
					key = '키';
				}

				if (key == 'id') {
					key = '식별번호';
				}

				if (key == 'name') {
					key = '이름';
				}

				if (key == 'breed_group') {
					key = '품종그룹';
				}

				if (key == 'life_span') {
					key = '평균수명';
				}

				if (key == 'temperament') {
					key = '성격';
					//alert(value);
					var valueArray = value.split(',');
					//alert(valueArray);
					for (i = 0; i < valueArray.length; i++) {
						//alert(valueArray[i]);
						if (valueArray[i].trim() == 'Friendly') {
							valueArray[i] = '친근한';
						}
						if (valueArray[i].trim() == 'Loyal') {
							valueArray[i] = '충성스러운';
						}
						if (valueArray[i].trim() == 'Quiet') {
							valueArray[i] = '조용한';
						}
						if (valueArray[i].trim() == 'Charming') {
							valueArray[i] = '매력적인';
						}
					}

					$("#breed_data_table").append(
							"<tr><td>" + key + "</td><td>" + valueArray
									+ "</td></tr>");

				}

				if (key == 'country_code') {
					key = '국가코드';
				}

				if (key == 'bred_for') {
					key = '유형';
				}

				if (!(key == '성격')) {
					$("#breed_data_table").append(
							"<tr><td>" + key + "</td><td>" + value
									+ "</td></tr>");
				} else {
					return false;
				}

			});
		}

		function ajax_get(url, callback) {
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					console.log('responseText:' + xmlhttp.responseText);
					try {
						var data = JSON.parse(xmlhttp.responseText);
					} catch (err) {
						console
								.log(err.message + " in "
										+ xmlhttp.responseText);
						return;
					}
					callback(data);
				}
			};

			xmlhttp.open("GET", url, true);
			xmlhttp.send();
		}

		getBreeds();
	</script>

</body>

</html>