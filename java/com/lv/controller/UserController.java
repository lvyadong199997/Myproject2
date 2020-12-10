package com.lv.controller;


import com.lv.pojo.Result;
import com.lv.pojo.User;
import com.lv.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;

//主要功能 用户登录 用户注册 用户注销

@RequestMapping("/user")
@Controller
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    HttpServletRequest request;


    //用户登录功能
    @RequestMapping("/login")
    public String login(String username, String password, HttpServletResponse response, HttpSession session, Integer fromPid) throws Exception {
        // 这个地方应该会用到session 后期会改的 注意  已经完成

        //这个地方是持久化session 保持一天
        Cookie c = new Cookie("JSESSIONID", session.getId());
        c.setPath("/");
        c.setMaxAge(60*60*24);


        User user = userService.findUser(username, password);
        if (user != null) {
            //2 用户登录成功 记录用户的用户名 返回到首页
            //将用户存储到session中  主要是为了判断用户是否登录
            session.setAttribute("user", user);
            Cookie cookie = new Cookie("username", username);
            //保存cookie一天
            cookie.setMaxAge(60*60*24);
            cookie.setPath("/");
            response.addCookie(c);
            response.addCookie(cookie);
            if (fromPid != null) {
                //从详情页跳转过来的
                return "redirect:/detail/" + fromPid;
            }
            return "redirect:/indexPage";
        } else {
            request.setAttribute("message", "用户名或者密码错误");
            return "forward:/loginPage";
        }

    }


    //用户退出登录
    @RequestMapping("/loginOut")
    public String loginOut(HttpServletResponse response, HttpSession session) {
        // 清空cookie 1 保证同名键  2 保证相同的携带路径 3设置最大生命周期为 0
        // 这里后期可以设置cookie的最大生命值

        //用户退出登录 将用户从session中清除
        session.setAttribute("user", null);
        session.setAttribute("cart",null);
        Cookie cookie = new Cookie("username", "");
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        return "redirect:/indexPage";
    }

    //用户注册
    @RequestMapping("/register")
    public String register(User user) {
        //这个地方就不对数据进行校验了 前端写写就行了
        //获取前端的User对象 设置一些属性  比如注册的时间 yyyy-MM-dd  HH:mm:ss
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
        String time = sdf.format(new Date());
        user.setRegisterTime(time);
        //调用Service 储存到数据库中
        userService.saveUser(user);
        return "redirect:/loginPage";
    }


    //确保用户唯一
    @RequestMapping("/findUser")
    @ResponseBody
    public Result findUser(String username) {
        User user = userService.findUniqueUsername(username);
        if (user != null) {
            //用户名已经存在
            Result result = new Result(false, "用户名已经存在");
            return result;

        }
        //用户名不存在
        Result result = new Result(true, "用户名不存在");
        return result;

    }

}
