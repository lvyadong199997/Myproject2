  // 页面加载完后执行函数
  $(function() {
      // 获取 加按钮 
      $("#add").on("click", function() {
          $("#pCount").val(parseInt($("#pCount").val()) + 1);
      });
      // 获取减按钮 
      $("#sub").on("click", function() {
          if (parseInt($("#pCount").val()) > 1) {
              $("#pCount").val(parseInt($("#pCount").val()) - 1);
          } else {
              $("#pCount").prop({
                  // 禁止点击
                  disabled: false
              })
          }

      });

      // 获取规格集合  处理一些js效果
      $("#speci li").each(function(i, ele) {
          $(ele).on("click", function() {

              $("#speci li").each(function(i, ele) {
                  // 干掉所有 留下自己
                  ele.className = "";
                  ele.children[0].className = "";

              });

              this.className = "active3";
              this.children[0].className = "active4";

          })

      });

      // 获取颜色集合  处理一些js效果
      $("#color li").each(function(i, ele) {
          $(ele).on("click", function() {

              $("#color li").each(function(i, ele) {
                  // 干掉所有 留下自己
                  ele.className = "";
                  ele.children[0].className = "";


              });

              this.className = "active3";
              this.children[0].className = "active4";

          })

      });

      // 加入购物车的一些效果  主要获取规格和颜色的内容
      $("#addCart").on("click", function() {
          var speci = $("#speci li").filter(".active3").text();
          var speciIndex = $("#speci li").filter(".active3").attr("index");
          var color = $("#color li").filter(".active3").text();
          var colorIndex = $("#color li").filter(".active3").attr("index");
          var pcount = $("#pCount").val();
          var url=location.href;
          var pId=url.split("/")[url.split("/").length - 1];
          console.log("规格为" + speci);
          console.log("规格索引为" + speciIndex);
          console.log("颜色为" + color);
          console.log("颜色索引为" + colorIndex);
          console.log("购买数量为" + pcount);
          console.log("pId为" + pId);
          //未完待续
          location.href="../cart/add?pId="+pId+"&count="+pcount+"&colorIndex="+colorIndex+"&speciIndex="+speciIndex+"";
      });


  })