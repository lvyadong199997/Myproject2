package com.lv.pojo;

//前后端使用ajax发送数据的结果集


import java.util.List;

public class Result {

    private Boolean success;
    private String message;
    private List<Object> data;

    @Override
    public String toString() {
        return "Result{" +
                "success=" + success +
                ", message='" + message + '\'' +
                ", data=" + data +
                '}';
    }

    public Result() {
    }

    public Result(Boolean success, String message, List<Object> data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }

    public Result(Boolean success, String message) {
        this.success = success;
        this.message = message;
    }

    public Boolean getSuccess() {
        return success;
    }

    public void setSuccess(Boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<Object> getData() {
        return data;
    }

    public void setData(List<Object> data) {
        this.data = data;
    }
}
