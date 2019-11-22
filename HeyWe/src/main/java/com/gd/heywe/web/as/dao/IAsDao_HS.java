package com.gd.heywe.web.as.dao;

import java.util.HashMap;
import java.util.List;

public interface IAsDao_HS {

	public int ASGetSolCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> ASGetSolList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> ASGetSolDtl(HashMap<String, String> params) throws Throwable;

	public void ASRegiSol(HashMap<String, String> params) throws Throwable;

	public int ASGetEmpCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> ASGetEmpList(HashMap<String, String> params) throws Throwable;

	public void ASRegiEmp(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> AsSolDtl(HashMap<String, String> params) throws Throwable;

	public int AsSolUpdate(HashMap<String, String> params) throws Throwable;

	public int AsSolDelete(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> AsEmpDtl(HashMap<String, String> params) throws Throwable;

	public int AsEmpUpdate(HashMap<String, String> params) throws Throwable;

	public int AsEmpDelete(HashMap<String, String> params) throws Throwable;

	public void ASRegiCar(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> AsTableDtl(HashMap<String, String> params) throws Throwable;


}
