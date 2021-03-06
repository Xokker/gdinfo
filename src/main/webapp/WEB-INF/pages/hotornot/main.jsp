<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bootstrap</title>
    <!-- Bootstrap -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <style type="text/css">

        .deputy-block {
            display: inline-block;
            width: 170px;
        }
        .deputy-block .title {
            display: block;
        }
        .choise, .results {
            text-align: center;
            margin: 0 auto;
        }
        .choise {
            width: 600px;
            height: 210px;
        }
        .results {
            width: 600px;
        }
        .versus {
            display: inline-block;
            position: relative;
            top: -100px;
        }
        td > .label{
            display: block;
            width: 50px;
        }
        .num{
            width: 30px;
        }
        .h1 {
            width: 400px!important;
        }
        .centered {
            text-align: center;
        }
    </style>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" ></script>
    <script>
        $(function(){
            var jsonMassive;
            var url;
            $.ajax({
                type: "GET",
                url: "/hotornot/ajax.json",
                success: function(result){
                    jsonMassive = result;
                    images = $(".img-thumbnail");
                    for(i=0; i<2; i++){
                        images.eq(i).attr("src",jsonMassive[i]["bigPhotoURL"]);
                        $(".deputy-block").eq(i).children("a").eq(1).attr("href","/"+jsonMassive[i]["id"]);
                        $(".deputy-block").eq(i).children("a").eq(1).text(jsonMassive[i]["firstName"] + " " + jsonMassive[i]["lastName"]);
                    }
                },
                dataType:"json"
            });
            $(".deputy-block").children("a").click(function(e) {
                e.preventDefault();

                index = $(this).parent().index();
                if (index == 0) {
                    url = "/hotornot/ajax.json?first="+jsonMassive[0]["id"]+"&second="+jsonMassive[1]["id"]+"&result=left";
                } else {
                    url = "/hotornot/ajax.json?first="+jsonMassive[0]["id"]+"&second="+jsonMassive[1]["id"]+"&result=right";
                }
                $.ajax({
                    type:"GET",
                    url: url,
                    success: function(result){
                        var images = $(".img-thumbnail")
                        var jsonMassive = result;
                        var deps = $(".deputy-block");
                        deps.fadeOut();
                        for(i=0;i<2;i++){
                            var depBlock = deps.eq(i)

                            images.eq(i).attr("src",jsonMassive[i]["bigPhotoURL"]);

                            depBlock.children("a").eq(1).attr("href","http://hotduma.com/"+jsonMassive[i]["id"]);
                            depBlock.children("a").eq(1).text(jsonMassive[i]["firstName"] + " " + jsonMassive[i]["lastName"]);
                        }
                        deps.fadeIn();
                    },
                    dataType:"json"
                })
            });
        });
    </script>
</head>
<body>

<jsp:include page="../menu.jsp" />

<div class="container">
    <h1 class="centered">Кому Вы больше доверяете?</h1>
    <div class="choise">
        <%--<div class="deputy-block">--%>
            <%--<a href="<c:url value="/hotornot">--%>
            <%--<c:param name="first" value="${leftDeputy.id}" />--%>
            <%--<c:param name="second" value="${rightDeputy.id}" />--%>
            <%--<c:param name="result" value="left" />--%>
            <%--</c:url>"><img src="${leftDeputy.bigPhotoURL}" class="img-thumbnail"></a>--%>
            <%--<a href="<c:url value="/${leftDeputy.id}"/>" class="title">${leftDeputy.lastName}</a>--%>
        <%--</div>--%>
        <div class="deputy-block">
            <a href=""><img src="" class="img-thumbnail"></a>
            <a href="" class="title"></a>
        </div>
        <div class="versus">
            <span style="font-size: 20px;" class="label label-primary">vs</span>
        </div>
        <div class="deputy-block">
            <a href=""><img src="" class="img-thumbnail"></a>
            <a href="" class="title"></a>
        </div>
    </div>

    <div class="results">
        <h3>Результаты</h3>
        <table class="table" style="text-align: left">
            <thead>
            <tr>
                <th class="num">№</th>
                <th>Депутат</th>
                <th>Плюсов</th>
                <th>Минусов</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="dep" items="${rating}" varStatus="counter">
                <tr>
                    <td><p>${counter.count}</p></td>
                    <td><a href="<c:url value="/${dep.id}"/>">${dep.firstName} ${dep.lastName}</a></td>
                    <td><span class="label label-success"><c:out value="${dep.positiveVoices}"/></span></td>
                    <td><span class="label label-warning"><c:out value="${dep.negativeVoices}"/></span></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</div><!-- /.container -->

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
</div>
</body>
</html>