<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
</head>
<body>
	<h1>Hello ToastUI</h1>
	<div id="editor"></div>
	<button onclick="seeHtml()">html보기</button>
	<button onclick="seeMd()">markdown보기</button>
	<script>
	 	$(document).ready(function(){

	 		const Editor = toastui.Editor;
		
			const editor = new Editor({
				  el: document.querySelector('#editor'),
				  height: '600px',
				  initialEditType: 'markdown',
				  previewStyle: 'vertical'
				});
			
			seeHtml = function(){
				alert(editor.getHTML());
			}
			seeMd = function(){
				alert(editor.getMarkdown());
			}
	 	});
	</script>
 
</body>

</html>