package com.gd.heywe.web.common.service;

import java.util.HashMap;
import java.util.List;

public interface IMainService {

	List<HashMap<String, String>> getArticle(HashMap<String, String> params) throws Throwable;

}
