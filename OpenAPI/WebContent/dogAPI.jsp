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
		<p>ǰ������</p>


		<select class="breed_select">
			<option></option>
		</select>

	</div>
	<div id="breed_data">
		<img id="breed_image" src="" />
		<p>ǰ�� ����</p>
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
								value.name = '��������';
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
											"<tr><td>���� �ۼ��Ǿ� ���� ���� ǰ�� ���� �Դϴ�.</td></tr>");
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
					key = '����';
				}

				if (key == 'height') {
					key = 'Ű';
				}

				if (key == 'id') {
					key = '�ĺ���ȣ';
				}

				if (key == 'name') {
					key = '�̸�';
				}

				if (key == 'breed_group') {
					key = 'ǰ���׷�';
				}

				if (key == 'life_span') {
					key = '��ռ���';
				}

				if (key == 'temperament') {
					key = '����';
					//alert(value);
					var valueArray = value.split(',');
					//alert(valueArray);
					for (i = 0; i < valueArray.length; i++) {
						//alert(valueArray[i]);
						if (valueArray[i].trim() == 'Friendly') {
							valueArray[i] = 'ģ����';
						}
						if (valueArray[i].trim() == 'Loyal') {
							valueArray[i] = '�漺������';
						}
						if (valueArray[i].trim() == 'Quiet') {
							valueArray[i] = '������';
						}
						if (valueArray[i].trim() == 'Charming') {
							valueArray[i] = '�ŷ�����';
						}
					}

					$("#breed_data_table").append(
							"<tr><td>" + key + "</td><td>" + valueArray
									+ "</td></tr>");

				}

				if (key == 'country_code') {
					key = '�����ڵ�';
				}

				if (key == 'bred_for') {
					key = '����';
				}

				if (!(key == '����')) {
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