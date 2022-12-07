	const ERROR_MESSAGE=[
		{errMsgId:'REQUIRED', message:'{0}은(는) 필수입력입니다.'},
		{errMsgId:'MIN', message:'{0}은(는) 최소 {1} 입니다.'},
		{errMsgId:'MAX', message:'{0}은(는) 최대 {1} 입니다.'},
		{errMsgId:'BGNG_DATE_ERROR_CODE', message:'시작일자는 종료일자보다 작아야 합니다..'}		,
		{errMsgId:'END_DATE_ERROR_CODE', message:'종료일자는 시작일자보다  커야 합니다.'}		
	];
	/*tui-grid 그리드에서 사용하기 위한 text box*/
	class CustomTextEditor {
		constructor(props) {
			const el = document.createElement('input');
			const { maxLength } = props.columnInfo.editor.options;

			el.type = 'text';
			el.maxLength = maxLength;
			el.value = String(props.value);
			this.el = el;
		}
		getElement() {
			return this.el;
		}
		getValue() {
			return this.el.value;
		}
		mounted() {
			this.el.select();
		}
	}
	const Grid = tui.Grid;

	Grid.applyTheme('striped', {
		cell: {
			header: {
				background: '#eef1f5'
			},
			evenRow: {
				background: '#edeff5'
			} 
		}
	});
	
/*
objId: select 의 id
cmmCd : 공통코드ID
option : 전체/선택 여부 
 */
function setSelectComponent(objId, cmmCd, option){
	
	$.ajax({
			url :contextRoot+"/cmm/selectCmmCdDtlList.ajax"
	        ,type: "POST"
	        ,data : {'cmmCd':cmmCd}//parameter
	        ,dataType: 'json'  	   
	        ,success : function(data){
				if(option=="ALL"){
					$('#'+objId).append('<option value="">전체</option>');
				}else if(option=="SELECT"){
					$('#'+objId).append('<option value="">선택</option>');
				}
				$(data.cmmCdDtlList).each(function(){
					$('#'+objId).append('<option value="'+this.cmmCdvl+'">'+this.cmmCdvlNm+'</option>');
				});
			}
		    ,error: function(){
		    	
		    }
		});
}	
//오늘날짜
function getToday(){
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	
	if(month<10){
		month='0'+month;
	}
	if(day<10){
		day='0'+day;
	}
	return year+'-'+month+'-'+day;
}
function getErrorMessage(){
		
	var message = ERROR_MESSAGE.filter(errMsg=>errMsg.errMsgId==arguments[0])[0].message;
	var retMsg = message;
	$(arguments).each(function(index){
		if(index!=0){
			
			retMsg = message.replaceAll('{'+(index-1)+'}',arguments[index]);
		}
	});
	return retMsg;
}
function under2camel(str){
	return str.toLowerCase().replace(/(\_[a-z])/g, function(arg){
		return arg.toUpperCase().replace('_','');
	});
}