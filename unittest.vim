if exists('g:user_zen_settings')
  let s:old_user_zen_settings = g:user_zen_settings
  unlet! g:user_zen_settings
endif
so zencoding.vim

unlet! testgroups
let testgroups = eval(join(filter(split(substitute(join(readfile(expand('<sfile>')), "\n"), '.*\nfinish\n', '', ''), '\n', 1), "v:val !~ '^\"'")))
for testgroup in testgroups
  echohl MatchParen | echon "[" testgroup.category."]\n" | echohl None
  let tests = testgroup.tests
  let start = reltime()
  for n in range(len(tests))
    let testtitle = tests[n].name
    let testtitle = len(testtitle) < 57 ? (testtitle.repeat(' ', 57-len(testtitle))) : strpart(testtitle, 0, 57)
    echohl ModeMsg | echon "testing #".printf("%03d", n+1)
    echohl None | echon ": ".testtitle." ... "
    unlet! res | let res = ZenExpand(tests[n].query, '', 0)
    if res == tests[n].result
      echohl Title | echon "ok\n" | echohl None
    else
      echohl WarningMsg | echon "ng\n" | echohl None
      echohl ErrorMsg | echo "failed test #".(n+1) | echohl None
  	echo "    expect:".tests[n].result
  	echo "       got:".res
  	echo ""
    endif
  endfor
  echo "past:".reltimestr(reltime(start))."\n"
endfor

if exists('g:user_zen_settings')
  let g:user_zen_settings = s:old_user_zen_settings
endif
 
finish
[
{
  'category': 'html',
  'tests': [
    {
      'name': "html:xt>div#header>div#logo+ul#nav>li.item-$*5>a",
      'query': "html:xt>div#header>div#logo+ul#nav>li.item-$*5>a",
      'type': "html",
      'result': "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\">\n<head>\n    <meta http-equiv=\"Content-Type\" content=\"text/html;charset=UTF-8\" />\n    <title></title>\n</head>\n<body>\n\t<div id=\"header\">\n\t\t<div id=\"logo\"></div>\n\t\t<ul id=\"nav\">\n\t\t\t<li class=\"item-1\">\n\t\t\t\t<a href=\"\"></a>\n\t\t\t</li>\n\t\t\t<li class=\"item-2\">\n\t\t\t\t<a href=\"\"></a>\n\t\t\t</li>\n\t\t\t<li class=\"item-3\">\n\t\t\t\t<a href=\"\"></a>\n\t\t\t</li>\n\t\t\t<li class=\"item-4\">\n\t\t\t\t<a href=\"\"></a>\n\t\t\t</li>\n\t\t\t<li class=\"item-5\">\n\t\t\t\t<a href=\"\"></a>\n\t\t\t</li>\n\t\t</ul>\n\t</div>\n\t\n</body>\n</html>",
    },
    {
      'name': "ol>li*2",
      'query': "ol>li*2",
      'type': "html",
      'result': "<ol>\n\t<li></li>\n\t<li></li>\n</ol>\n",
    },
    {
      'name': "a",
      'query': "a",
      'type': "html",
      'result': "<a href=\"\"></a>\n",
    },
    {
      'name': "obj",
      'query': "obj",
      'type': "html",
      'result': "<object data=\"\" type=\"\"></object>\n",
    },
    {
      'name': "cc:ie6>p+blockquote#sample$.so.many.classes*2",
      'query': "cc:ie6>p+blockquote#sample$.so.many.classes*2",
      'type': "html",
      'result': "<!--[if lte IE 6]>\n\t<p></p>\n\t<blockquote id=\"sample1\" class=\"classes\"></blockquote>\n\t<blockquote id=\"sample2\" class=\"classes\"></blockquote>\n\t\n<![endif]-->",
    },
    {
      'name': "tm>if>div.message",
      'query': "tm>if>div.message",
      'type': "html",
      'result': "<tm>\n\t<if>\n\t\t<div class=\"message\"></div>\n\t</if>\n</tm>\n",
    },
    {
      'name': "html:4t>div#wrapper>div#header+div#contents+div#footer",
      'query': "html:4t>div#wrapper>div#header+div#contents+div#footer",
      'type': "html",
      'result': "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\n<html lang=\"en\">\n<head>\n    <meta http-equiv=\"Content-Type\" content=\"text/html;charset=UTF-8\">\n    <title></title>\n</head>\n<body>\n\t<div id=\"wrapper\">\n\t\t<div id=\"header\"></div>\n\t\t<div id=\"contents\"></div>\n\t\t<div id=\"footer\"></div>\n\t</div>\n\t\n</body>\n</html>",
    },
    {
      'name': "a[href=http://www.google.com/].foo#hoge",
      'query': "a[href=http://www.google.com/].foo#hoge",
      'type': "html",
      'result': "<a id=\"hoge\" href=\"http://www.google.com/\" class=\"foo\"></a>\n",
    },
    {
      'name': "a[href=http://www.google.com/]{Google}",
      'query': "a[href=http://www.google.com/]{Google}",
      'type': "html",
      'result': "<a href=\"http://www.google.com/\">Google</a>\n",
    },
    {
      'name': "{ZenCoding}",
      'query': "{ZenCoding}",
      'type': "html",
      'result': "ZenCoding",
    },
    {
      'name': "a+b",
      'query': "a+b",
      'type': "html",
      'result': "<a href=\"\"></a>\n<b></b>\n",
    },
    {
      'name': "a>b>c<d",
      'query': "a>b>c<d",
      'type': "html",
      'result': "<a href=\"\"><b><c></c></b><d></d></a>\n",
    },
    {
      'name': "a>b>c<<d",
      'query': "a>b>c<<d",
      'type': "html",
      'result': "<a href=\"\"><b><c></c></b></a>\n<d></d>\n",
    },
    {
      'name': "blockquote>b>c<<d",
      'query': "blockquote>b>c<<d",
      'type': "html",
      'result': "<blockquote>\n\t<b><c></c></b>\n</blockquote>\n<d></d>\n",
    },
    {
      'name': "a[href=foo][class=bar]",
      'query': "a[href=foo][class=bar]",
      'type': "html",
      'result': "<a href=\"foo\" class=\"bar\"></a>\n",
    },
    {
      'name': "a[a=b][b=c=d][e]{foo}*2",
      'query': "a[a=b][b=c=d][e]{foo}*2",
      'type': "html",
      'result': "<a a=\"b\" b=\"c=d\" e=\"\" href=\"\">foo</a>\n<a a=\"b\" b=\"c=d\" e=\"\" href=\"\">foo</a>\n",
    },
    {
      'name': "a[a=b][b=c=d][e]*2{foo}",
      'query': "a[a=b][b=c=d][e]*2{foo}",
      'type': "html",
      'result': "<a a=\"b\" b=\"c=d\" e=\"\" href=\"\"></a>\n<a a=\"b\" b=\"c=d\" e=\"\" href=\"\"></a>\nfoo",
    },
    {
      'name': "a*2{foo}a",
      'query': "a*2{foo}a",
      'type': "html",
      'result': "<a href=\"\"></a>\n<a href=\"\"></a>\nfoo<a href=\"\"></a>\n",
    },
    {
      'name': "a{foo}*2>b",
      'query': "a{foo}*2>b",
      'type': "html",
      'result': "<a href=\"\">foo<b></b></a>\n<a href=\"\">foo<b></b></a>\n",
    },
    {
      'name': "a*2{foo}>b",
      'query': "a*2{foo}>b",
      'type': "html",
      'result': "<a href=\"\"></a>\n<a href=\"\"></a>\nfoo",
    },
    {
      'name': "table>tr>td.name#foo+td*3",
      'query': "table>tr>td.name#foo+td*3",
      'type': "html",
      'result': "<table>\n\t<tr>\n\t\t<td id=\"foo\" class=\"name\"></td>\n\t\t<td></td>\n\t\t<td></td>\n\t\t<td></td>\n\t</tr>\n</table>\n",
    },
    {
      'name': "div#header + div#footer",
      'query': "div#header + div#footer",
      'type': "html",
      'result': "<div id=\"header\"></div>\n<div id=\"footer\"></div>\n",
    },
    {
      'name': "#header + div#footer",
      'query': "#header + div#footer",
      'type': "html",
      'result': "<div id=\"header\"></div>\n<div id=\"footer\"></div>\n",
    },
    {
      'name': "#header > ul > li < p{Footer}",
      'query': "#header > ul > li < p{Footer}",
      'type': "html",
      'result': "<div id=\"header\">\n\t<ul>\n\t\t<li></li>\n\t</ul>\n\t<p>Footer</p>\n</div>\n",
    },
    {
      'name': "a#foo$$$*3",
      'query': "a#foo$$$*3",
      'type': "html",
      'result': "<a id=\"foo111\" href=\"\"></a>\n<a id=\"foo222\" href=\"\"></a>\n<a id=\"foo333\" href=\"\"></a>\n",
    },
    {
      'name': "ul+",
      'query': "ul+",
      'type': "html",
      'result': "<ul>\n\t<li></li>\n</ul>\n",
    },
    {
      'name': "#header>li<#content",
      'query': "#header>li<#content",
      'type': "html",
      'result': "<div id=\"header\">\n\t<li></li>\n</div>\n<div id=\"content\"></div>\n",
    },
    {
      'name': "(#header>li)<#content",
      'query': "(#header>li)<#content",
      'type': "html",
      'result': "<div id=\"header\">\n\t<li></li>\n</div>\n<div id=\"content\"></div>\n",
    },
    {
      'name': "a>b>c<<div",
      'query': "a>b>c<<div",
      'type': "html",
      'result': "<a href=\"\"><b><c></c></b></a>\n<div></div>\n",
    },
    {
      'name': "(#header>h1)+#content+#footer",
      'query': "(#header>h1)+#content+#footer",
      'type': "html",
      'result': "<div id=\"header\">\n\t<h1></h1>\n</div>\n<div id=\"content\"></div>\n<div id=\"footer\"></div>\n",
    },
    {
      'name': "(#header>h1)+(#content>(#main>h2+div#entry$.section*5>(h3>a)+div>p*3+ul+)+(#utilities))+(#footer>address)",
      'query': "(#header>h1)+(#content>(#main>h2+div#entry$.section*5>(h3>a)+div>p*3+ul+)+(#utilities))+(#footer>address)",
      'type': "html",
      'result': "<div id=\"header\">\n\t<h1></h1>\n</div>\n<div id=\"content\">\n\t<div id=\"main\">\n\t\t<h2></h2>\n\t\t<div id=\"entry1\" class=\"section\">\n\t\t\t<h3>\n\t\t\t\t<a href=\"\"></a>\n\t\t\t</h3>\n\t\t\t<div>\n\t\t\t\t<p></p>\n\t\t\t\t<p></p>\n\t\t\t\t<p></p>\n\t\t\t\t<ul>\n\t\t\t\t\t<li></li>\n\t\t\t\t</ul>\n\t\t\t</div>\n\t\t</div>\n\t\t<div id=\"entry2\" class=\"section\">\n\t\t\t<h3>\n\t\t\t\t<a href=\"\"></a>\n\t\t\t</h3>\n\t\t\t<div>\n\t\t\t\t<p></p>\n\t\t\t\t<p></p>\n\t\t\t\t<p></p>\n\t\t\t\t<ul>\n\t\t\t\t\t<li></li>\n\t\t\t\t</ul>\n\t\t\t</div>\n\t\t</div>\n\t\t<div id=\"entry3\" class=\"section\">\n\t\t\t<h3>\n\t\t\t\t<a href=\"\"></a>\n\t\t\t</h3>\n\t\t\t<div>\n\t\t\t\t<p></p>\n\t\t\t\t<p></p>\n\t\t\t\t<p></p>\n\t\t\t\t<ul>\n\t\t\t\t\t<li></li>\n\t\t\t\t</ul>\n\t\t\t</div>\n\t\t</div>\n\t\t<div id=\"entry4\" class=\"section\">\n\t\t\t<h3>\n\t\t\t\t<a href=\"\"></a>\n\t\t\t</h3>\n\t\t\t<div>\n\t\t\t\t<p></p>\n\t\t\t\t<p></p>\n\t\t\t\t<p></p>\n\t\t\t\t<ul>\n\t\t\t\t\t<li></li>\n\t\t\t\t</ul>\n\t\t\t</div>\n\t\t</div>\n\t\t<div id=\"entry5\" class=\"section\">\n\t\t\t<h3>\n\t\t\t\t<a href=\"\"></a>\n\t\t\t</h3>\n\t\t\t<div>\n\t\t\t\t<p></p>\n\t\t\t\t<p></p>\n\t\t\t\t<p></p>\n\t\t\t\t<ul>\n\t\t\t\t\t<li></li>\n\t\t\t\t</ul>\n\t\t\t</div>\n\t\t</div>\n\t</div>\n\t<div id=\"utilities\"></div>\n</div>\n<div id=\"footer\">\n\t<address></address>\n</div>\n",
    },
    {
      'name': "(div>(ul*2)*2)+(#utilities)",
      'query': "(div>(ul*2)*2)+(#utilities)",
      'type': "html",
      'result': "<div>\n\t<ul></ul>\n\t<ul></ul>\n\t<ul></ul>\n\t<ul></ul>\n</div>\n<div id=\"utilities\"></div>\n",
    },
    {
      'name': "table>(tr>td*3)*4",
      'query': "table>(tr>td*3)*4",
      'type': "html",
      'result': "<table>\n\t<tr>\n\t\t<td></td>\n\t\t<td></td>\n\t\t<td></td>\n\t</tr>\n\t<tr>\n\t\t<td></td>\n\t\t<td></td>\n\t\t<td></td>\n\t</tr>\n\t<tr>\n\t\t<td></td>\n\t\t<td></td>\n\t\t<td></td>\n\t</tr>\n\t<tr>\n\t\t<td></td>\n\t\t<td></td>\n\t\t<td></td>\n\t</tr>\n</table>\n",
    },
    {
      'name': "(((a#foo+a#bar)*2)*3)",
      'query': "(((a#foo+a#bar)*2)*3)",
      'type': "html",
      'result': "<a id=\"foo\" href=\"\"></a>\n<a id=\"bar\" href=\"\"></a>\n<a id=\"foo\" href=\"\"></a>\n<a id=\"bar\" href=\"\"></a>\n<a id=\"foo\" href=\"\"></a>\n<a id=\"bar\" href=\"\"></a>\n<a id=\"foo\" href=\"\"></a>\n<a id=\"bar\" href=\"\"></a>\n<a id=\"foo\" href=\"\"></a>\n<a id=\"bar\" href=\"\"></a>\n<a id=\"foo\" href=\"\"></a>\n<a id=\"bar\" href=\"\"></a>\n",
    },
    {
      'name': "div#box$*3>h3+p*2",
      'query': "div#box$*3>h3+p*2",
      'result': "<div id=\"box1\">\n\t<h3></h3>\n\t<p></p>\n\t<p></p>\n</div>\n<div id=\"box2\">\n\t<h3></h3>\n\t<p></p>\n\t<p></p>\n</div>\n<div id=\"box3\">\n\t<h3></h3>\n\t<p></p>\n\t<p></p>\n</div>\n"
    },
    {
      'name': "div#box$*3>h3+p.bar*2|e",
      'query': "div#box$*3>h3+p.bar*2|e",
      'result': "&lt;div id=\"box1\"&gt;\n\t&amp;lt;h3&amp;gt;&amp;lt;/h3&amp;gt;\n\t&amp;lt;p class=\"bar\"&amp;gt;&amp;lt;/p&amp;gt;\n\t&amp;lt;p class=\"bar\"&amp;gt;&amp;lt;/p&amp;gt;\n&lt;/div&gt;\n&lt;div id=\"box2\"&gt;\n\t&amp;lt;h3&amp;gt;&amp;lt;/h3&amp;gt;\n\t&amp;lt;p class=\"bar\"&amp;gt;&amp;lt;/p&amp;gt;\n\t&amp;lt;p class=\"bar\"&amp;gt;&amp;lt;/p&amp;gt;\n&lt;/div&gt;\n&lt;div id=\"box3\"&gt;\n\t&amp;lt;h3&amp;gt;&amp;lt;/h3&amp;gt;\n\t&amp;lt;p class=\"bar\"&amp;gt;&amp;lt;/p&amp;gt;\n\t&amp;lt;p class=\"bar\"&amp;gt;&amp;lt;/p&amp;gt;\n&lt;/div&gt;\n",
    },
    {
      'name': "div>div#page>p.title+p|c",
      'query': "div>div#page>p.title+p|c",
      'result': "<div>\n\t<!-- #page -->\n\t<div id=\"page\">\n\t\t<!-- .title -->\n\t\t<p class=\"title\"></p>\n\t\t<!-- /.title -->\n\t\t<p></p>\n\t</div>\n\t<!-- /#page -->\n</div>\n",
    },
  ],
},
{
  'category': 'css',
  'tests': [
    {
      'name': "@i",
      'query': "@i",
      'type': "css",
      'result': "<@i></@i>\n",
    },
    {
      'name': "link:css",
      'query': "link:css",
      'type': "html",
      'result': "<link media=\"all\" rel=\"stylesheet\" href=\"style.css\" type=\"text/css\" />\n",
    },
    {
      'name': "fs:n",
      'query': "fs:n",
      'type': "css",
      'result': "<fs></fs>\n",
    },
  ],
},
]
" vim:set et:
