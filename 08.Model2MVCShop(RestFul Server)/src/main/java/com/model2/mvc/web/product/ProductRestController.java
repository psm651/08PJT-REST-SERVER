package com.model2.mvc.web.product;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 회원관리 Controller
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	/*
	@RequestMapping(value="addProduct", method = RequestMethod.GET)
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");
	
		
		return "redirect:/product/addProductView.jsp";
	}
	//
	@RequestMapping(value="json/addProduct", method = RequestMethod.POST)
	public Product addProduct( @RequestBody Product product ) throws Exception {

		System.out.println("/product/json/addProduct : POST");
		//Business Logic
		Product product2=new Product();
		if (productService.addProduct(product)==1) {
			product2=product;
		}
	
		
		return product2;
		//return "forward:/product/addProductConform.jsp";
	}
	//
	@RequestMapping(value="json/getProduct/{prodNo}", method = RequestMethod.GET)
	public Product getProduct( @PathVariable("prodNo") int prodNo ,@CookieValue(value="history", required=false) String history, HttpServletResponse response, Model model ) throws Exception {
		
		System.out.println("json/getProduct/{prodNo} : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		
		if (history==null || history.length()==0) {
			history = prodNo+"";
		}else {
			if (history.indexOf(prodNo+"")==-1) {
				history = history+","+prodNo;
			}			
			
		}
		
		Cookie cookie= new Cookie("history", history);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		// Model 과 View 연결
		
		return product;
	}
//
	@RequestMapping(value="json/updateProduct/{prodNo}", method=RequestMethod.GET)
	public Product updateProduct( @PathVariable("prodNo") int prodNo ) throws Exception{

		System.out.println("/json/updateProduct/{prodNo} : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		
		
		return product;
	}*/
	//
	@RequestMapping(value="json/updateProduct", method=RequestMethod.POST)
	public Product updateProduct( @RequestBody Product product ) throws Exception{

		System.out.println("/json/updateProduct : POST");
		//Business Logic
		Product product2 = new Product();
		if (productService.updateProduct(product)==1) {
		 product2=productService.getProduct(product.getProdNo());	
		}
		
		return product2;
		
	
	}
	
	@RequestMapping(value="json/listProduct",method=RequestMethod.POST)
	public Map<String , Object> listProduct( @RequestBody Search search  , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/json/listProduct : POST");
		
		Map<String , Object> map = new HashMap();
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
	
		search.setPageSize(pageSize);
		search.setOrder(search.getOrder());
		
		// Business logic 수행
		
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		map.put("list", productService.getProductList(search));
		map.put("resultPage", resultPage);
		map.put("search", search);
	
		
		return map;
	}
	
	/*
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
	
		search.setPageSize(pageSize);
		search.setOrder(search.getOrder());
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
	
		
		return "forward:/product/listProduct.jsp";
	}*/
}