/*서비스기준 데이터*/
	//ajax로 불러온 데이터
	var srvcrData = [
			{
				srvcrId:'SVC000001',
				srvcrNm: '긴급복지지원급액1',
				srvcrDc: '긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~',
				srvcrViewNm: 'VW_ABCDEFD',
				taskDivSclsCd: '2',
				taskDivSclsNm: '공통',
				useBgngYmd: '2020-01-01',
				useEndYmd: '9999-12-31',
			},
			{
				srvcrId:'SVC000002',
				srvcrNm: '긴급복지지원급액2',
				srvcrDc: '긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~',
				srvcrViewNm: 'VW_ABCDEFD',
				taskDivSclsCd: '2',
				taskDivSclsNm: '공통',
				useBgngYmd: '2020-01-01',
				useEndYmd: '9999-12-31',
			},
			{
				srvcrId:'SVC000003',
				srvcrNm: '긴급복지지원급액3',
				srvcrDc: '긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~',
				srvcrViewNm: 'VW_ABCDEFD',
				taskDivSclsCd: '2',
				taskDivSclsNm: '공통',
				useBgngYmd: '2020-01-01',
				useEndYmd: '9999-12-31',
			},
			{
				srvcrId:'SVC000004',
				srvcrNm: '긴급복지지원급액4',
				srvcrDc: '긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~',
				srvcrViewNm: 'VW_ABCDEFD',
				taskDivSclsCd: '2',
				taskDivSclsNm: '공통',
				useBgngYmd: '2020-01-01',
				useEndYmd: '9999-12-31',
			},
			{
				srvcrId:'SVC000005',
				srvcrNm: '긴급복지지원급액5',
				srvcrDc: '긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~',
				srvcrViewNm: 'VW_ABCDEFD',
				taskDivSclsCd: '2',
				taskDivSclsNm: '공통',
				useBgngYmd: '2020-01-01',
				useEndYmd: '9999-12-31',
			},
			{
				srvcrId:'SVC000006',
				srvcrNm: '긴급복지지원급액6',
				srvcrDc: '긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~',
				srvcrViewNm: 'VW_ABCDEFD',
				taskDivSclsCd: '2',
				taskDivSclsNm: '공통',
				useBgngYmd: '2020-01-01',
				useEndYmd: '9999-12-31'				
			}
		]
	//ajax 로 불러온 데이터
	var srvcrItmData_SVC000001 =
	[
		{
			srvcrId:'SVC000001',
			critmId:'ST00001',
			critmNm:'국민연금관리공단활동ID',
			critmPhyNm:'NPNRR_ID',
			srvCritmOrd:1,
			idnfItmYn:'Y',
			useBgngYmd:'2000-01-01',
			useEndYmd:'9999-12-31',
			dmnGroupNm:'',
			cdvlTnm:'',
			dmnPhyNm:'',
			datatpNm:'VARCHAR2'
		},
		{
			srvcrId:'SVC000001',
			critmId:'ST00002',
			critmNm:'유효종료일시',
			critmPhyNm:'VLD_END_DT',
			srvCritmOrd:2,
			idnfItmYn:'Y',
			useBgngYmd:'2000-01-01',
			useEndYmd:'9999-12-31',
			dmnGroupNm:'',
			cdvlTnm:'',
			dmnPhyNm:'',
			datatpNm:'VARCHAR2'
		},
		{
			srvcrId:'SVC000001',
			critmId:'ST00003',
			critmNm:'유효시작일시',
			critmPhyNm:'VLD_BGNG_DT',
			srvCritmOrd:3,
			idnfItmYn:'Y',
			useBgngYmd:'2000-01-01',
			useEndYmd:'9999-12-31',
			dmnGroupNm:'',
			cdvlTnm:'',
			dmnPhyNm:'',
			datatpNm:'VARCHAR2'
		},
		{
			srvcrId:'SVC000001',
			critmId:'ST00004',
			critmNm:'최소점수',
			critmPhyNm:'MIN_SCR',
			srvCritmOrd:4,
			idnfItmYn:'N',
			useBgngYmd:'2000-01-01',
			useEndYmd:'9999-12-31',
			dmnGroupNm:'',
			cdvlTnm:'',
			dmnPhyNm:'',
			datatpNm:'NUMBER'
		},
		{
			srvcrId:'SVC000001',
			critmId:'ST00005',
			critmNm:'최대점수',
			critmPhyNm:'MAX_SCR',
			srvCritmOrd:5,
			idnfItmYn:'N',
			useBgngYmd:'2000-01-01',
			useEndYmd:'9999-12-31',
			dmnGroupNm:'',
			cdvlTnm:'',
			dmnPhyNm:'',
			datatpNm:'NUMBER'
		}
	]
	//ajax로 불러온 데이터
	var srvcrItmData_SVC000002 =
	[
		{
			srvcrId:'SVC000002',
			critmId:'ST00006',
			critmNm:'기준연도',
			critmPhyNm:'CRTR_YR',
			srvCritmOrd:1,
			idnfItmYn:'Y',
			useBgngYmd:'2000-01-01',
			useEndYmd:'9999-12-31',
			dmnGroupNm:'',
			cdvlTnm:'',
			dmnPhyNm:'',
			datatpNm:'VARCHAR2'
		},
		{
			srvcrId:'SVC000002',
			critmId:'ST00007',
			critmNm:'서비스ID',
			critmPhyNm:'SRV_ID',
			srvCritmOrd:2,
			idnfItmYn:'Y',
			useBgngYmd:'2000-01-01',
			useEndYmd:'9999-12-31',
			dmnGroupNm:'',
			cdvlTnm:'',
			dmnPhyNm:'',
			datatpNm:'VARCHAR2'
		},
		{
			srvcrId:'SVC000002',
			critmId:'ST00002',
			critmNm:'유효종료일시',
			critmPhyNm:'VLD_END_DT',
			srvCritmOrd:3,
			idnfItmYn:'Y',
			useBgngYmd:'2000-01-01',
			useEndYmd:'9999-12-31',
			dmnGroupNm:'',
			cdvlTnm:'',
			dmnPhyNm:'',
			datatpNm:'VARCHAR2'
		},
		{
			srvcrId:'SVC000002',
			critmId:'ST00003',
			critmNm:'유효시작일시',
			critmPhyNm:'VLD_BGNG_DT',
			srvCritmOrd:4,
			idnfItmYn:'Y',
			useBgngYmd:'2000-01-01',
			useEndYmd:'9999-12-31',
			dmnGroupNm:'',
			cdvlTnm:'',
			dmnPhyNm:'',
			datatpNm:'VARCHAR2'
		},
		{
			srvcrId:'SVC000002',
			critmId:'ST00008',
			critmNm:'학교구분코드',
			critmPhyNm:'SCHL_DCD',
			srvCritmOrd:5,
			idnfItmYn:'N',
			useBgngYmd:'2000-01-01',
			useEndYmd:'9999-12-31',
			dmnGroupNm:'코드',
			cdvlTnm:'단순코드',
			dmnPhyNm:'DEPT_CD',
			datatpNm:'VARCHAR2'
			
		}
		,
		{
			srvcrId:'SVC000002',
			critmId:'ST00009',
			critmNm:'지원금액',
			critmPhyNm:'SPMN_AMT',
			srvCritmOrd:5,
			idnfItmYn:'N',
			useBgngYmd:'2000-01-01',
			useEndYmd:'9999-12-31',
			dmnGroupNm:'',
			cdvlTnm:'',
			dmnPhyNm:'',
			datatpNm:'NUMBER'
		}
	]

	/*기준항목데이터 */
var critmData = [
	{
		critmId:'ST00009',
		critmNm:'지원금액',
		critmPhyNm:'SPMN_AMT',
		datatpCd: '01',
		datatpNm: 'VARCHAR'
	},
	{
		critmId:'ST00008',
		critmNm:'학교구분코드',
		critmPhyNm:'SCHL_DCD',
		datatpCd: '01',
		datatpNm: 'VARCHAR'
	},
	{
		critmId:'ST00007',
		critmNm:'서비스ID',
		critmPhyNm:'SRV_ID',
		datatpCd: '01',
		datatpNm: 'VARCHAR'
	}
	,
	{
		critmId:'ST00006',
		critmNm:'기준연도',
		critmPhyNm:'CRTR_YR',
		datatpCd: '01',
		datatpNm: 'VARCHAR'
	}
	,
	{
		critmId:'ST00005',
		critmNm:'최대점수',
		critmPhyNm:'MAX_SCR',
		datatpCd: '01',
		datatpNm: 'VARCHAR'
	}
];

var taskDivSclsCdList = [
	{text:'공통',value:'1'},
	{text:'긴급복지',value:'2'},
	{text:'조사',value:'3'}
];

var srvcrHist=[
	{
		srvcrId:'SVC000001',
		srvcrNm: '긴급복지지원급액1',
		srvcrDc: '긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~',
		srvcrViewNm: 'VW_ABCDEFD',
		taskDivSclsCd: '2',
		taskDivSclsNm: '공통',
		useBgngYmd: '2020-01-01',
		useEndYmd: '9999-12-31',
		vldBgngDt:'2020-01-01',
		vldEndDt:'2020-12-31',
	},
	{
		srvcrId:'SVC000001',
		srvcrNm: '긴급복지지원급액1',
		srvcrDc: '긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~',
		srvcrViewNm: 'VW_ABCDEFD',
		taskDivSclsCd: '2',
		taskDivSclsNm: '공통',
		useBgngYmd: '2020-01-01',
		useEndYmd: '9999-12-31',
		vldBgngDt:'2021-01-01',
		vldEndDt:'2021-12-31',
	},
	{
		srvcrId:'SVC000001',
		srvcrNm: '긴급복지지원급액1',
		srvcrDc: '긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~긴급복지샬라샬라~~~',
		srvcrViewNm: 'VW_ABCDEFD',
		taskDivSclsCd: '2',
		taskDivSclsNm: '공통',
		useBgngYmd: '2020-01-01',
		useEndYmd: '9999-12-31',
		vldBgngDt:'2022-01-01',
		vldEndDt:'9999-12-31',
	},
]
var SVC000001_data = [
	{
		srvcrId:'SVC000001',
		idnfItmValDtlsSn:1,
		ST00001:'국민연금관리공단활동1',
		ST00002:'99991231235959',
		ST00003:'20210101000000',
		ST00004:'60',
		ST00005:'70',
		newYn:'N'
	},
	{
		srvcrId:'SVC000001',
		idnfItmValDtlsSn:2,
		ST00001:'국민연금관리공단활동2',
		ST00002:'99991231235959',
		ST00003:'20210101000000',
		ST00004:'60',
		ST00005:'70',
		newYn:'N'
	}
]
var SVC000001_국민연금관리공단활동1_histData = [
	{
		srvcrId:'SVC000001',
		idnfItmValDtlsSn:1,
		ST00001:'국민연금관리공단활동1',
		ST00002:'99991231235959',
		ST00003:'20210101000000',
		ST00004:'60',
		ST00005:'70'
	},
	{
		srvcrId:'SVC000001',
		idnfItmValDtlsSn:2,
		ST00001:'국민연금관리공단활동1',
		ST00002:'20201231235959',
		ST00003:'20200101000000',
		ST00004:'60',
		ST00005:'70'
	}
]
var SVC000001_국민연금관리공단활동2_histData = [
	{
		srvcrId:'SVC000001',
		idnfItmValDtlsSn:1,
		ST00001:'국민연금관리공단활동2',
		ST00002:'99991231235959',
		ST00003:'20210101000000',
		ST00004:'60',
		ST00005:'70'
	},
	{
		srvcrId:'SVC000001',
		idnfItmValDtlsSn:2,
		ST00001:'국민연금관리공단활동2',
		ST00002:'20201231235959',
		ST00003:'20200101000000',
		ST00004:'60',
		ST00005:'70'
	}
]