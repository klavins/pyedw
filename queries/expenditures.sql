SELECT 

RD.[FiscalYr] AS FiscalYear
	,RD.[CalendarMonthName] AS [FiscalMonth]
	,DB.[ReportingBudgetNbr] AS [Parent Budget Nbr]
	,DB.[BudgetNbr]
	,DB.[BudgetName]
	,DB.[PIName]
	,DB.[BudgetClassDesc]
	,DB.[ReportFunctionDesc]
	,DB.[ReportSubFunctionDesc]
	,FE.[FundingEntityReportingName] AS [OrigFEReportingName]
	,FDR.[FundingEntityReportingName] AS [Direct Sponsor]
	,FDR.[FundingEntityCategoryDesc] AS [Direct Sponsor Type]
	,FDR.[FederalIndDesc] AS [Direct Federal]
	,FIN.[FinOrgUnitNbr]
	,FIN.FinDepartmentNbr
	,Fin.[FinCollegeResearchReportingName]
	,Fin.[FinDepartmentReportingName]
	,DB.[GrantContractNbr]
	,BRG.[SponsoredProgramActivityTypeDesc] AS [SponsoredProgramActivityType]
	,SUM(CAST(FB.[ResearchExpenseNominalDirectAmt] AS DECIMAL(18, 0))) AS TotalNominalDirectExpenseAmt
	,SUM(CAST([ResearchExpenseNominalIndirectAmt] AS DECIMAL(18, 0))) TotalNominalIndirectExpenseAmt
	,SUM(CAST((FB.[ResearchExpenseNominalDirectAmt] + [ResearchExpenseNominalIndirectAmt]) AS DECIMAL(18, 0))) TotalNominalTotalExpenseAmt
                                                                                                      
FROM [sec].[RAD_factBudgetExpenditure] FB
INNER JOIN [sec].[RAD_dimBudget] DB ON FB.[BudgetPermId] = DB.[BudgetPermId]
INNER JOIN [sec].[dimDate] RD ON FB.ReportingDateKeyId = RD.[CalendarDateKeyId]
INNER JOIN [sec].[RAD_dimFinancialOrganizationBienCurrent] Fin ON FB.[FinOrgBienCurrentKeyId] = Fin.[FinOrgBienCurrentKeyId]
INNER JOIN [sec].[RAD_dimFundingEntityCurrent] FE ON FB.OriginatingFundingEntityPermId = FE.[FundingEntityPermId]
INNER JOIN [sec].[RAD_dimFundingEntityCurrent] FDR ON FB.FundingEntityPermId = FDR.FundingEntityPermId
LEFT OUTER JOIN [sec].[RAD_factAwardExpenditure] BRG ON FB.[BudgetPermId] = BRG.[BudgetPermId]
WHERE Fin.FinDepartmentNbr = @Orgcode 
	AND RD.[CalendarDate] BETWEEN @StartDate
		AND @EndDate
	AND [FinDepartmentName] <> 'General Accounting'
GROUP BY RD.[FiscalYr]
	,Fin.[FinCollegeResearchReportingName]
	,Fin.[FinDepartmentReportingName]
	,FIN.FinDepartmentNbr
	,DB.[ReportingBudgetNbr]
	,DB.[BudgetNbr]
	,DB.[BudgetName]
	,DB.[BudgetClassDesc]
	,DB.[ReportFunctionDesc]
	,DB.[ReportSubFunctionDesc]
	,FE.[FundingEntityReportingName]
	,FDR.[FundingEntityReportingName]
	,FDR.[FundingEntityCategoryDesc]
	,FDR.[FederalIndDesc]
	,FDR.[FundingEntityReportingName]
	,DB.[GrantContractNbr]
	,BRG.[SponsoredProgramActivityTypeDesc]
	,RD.[FiscalYrMonthNum]
	,RD.CalendarMonthName
	,DB.[PIName]
	,FIN.[FinOrgUnitNbr]

