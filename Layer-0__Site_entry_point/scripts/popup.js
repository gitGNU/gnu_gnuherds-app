/*
Original: Mike McGrath  (mike_mcgrath@lineone.net)
Web Site: http://website.lineone.net/~mike_mcgrath


Additional modification by: Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006 Davi Leal <davi at leals dot com>

This program is free software; you can redistribute it and/or modify it under
the terms of the Affero General Public License as published by Affero Inc.,
either version 1 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful to the Free
Software community, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the Affero
General Public License for more details.

You should have received a copy of the Affero General Public License with this
software in the ./AfferoGPL file; if not, write to Affero Inc., 510 Third Street,
Suite 225, San Francisco, CA 94107, USA
*/


var Xoffset=-300;       // modify these values to ...
var Yoffset= 20;        // change the popup position.
var popwidth=130;       // popup width
var bcolor="darkgray";  // popup border color
var fcolor="black";     // popup font color
var fface="verdana";    // popup font face

// create content box
document.write("<DIV ID='pup'></DIV>");

// id browsers
var iex=(document.all);
var nav=(document.layers);
var old=(navigator.appName=="Netscape" && !document.layers && !document.getElementById);
var n_6=(window.sidebar);

// assign object
var skin;
if(nav) skin=document.pup;
if(iex) skin=pup.style;
if(n_6) skin=document.getElementById("pup").style;

// park modifier
var yyy=-1000;

// capture pointer
if(nav)document.captureEvents(Event.MOUSEMOVE);
if(n_6) document.addEventListener("mousemove",get_mouse,true);
if(nav||iex)document.onmousemove=get_mouse;

// set dynamic coords
function get_mouse(e)
{
  var x,y;

  if(nav || n_6) x=e.pageX;
  if(iex) x=event.x+document.body.scrollLeft; 
  
  if(nav || n_6) y=e.pageY;
  if(iex)
  {
    y=event.y;
    if(navigator.appVersion.indexOf("MSIE 4")==-1)
      y+=document.body.scrollTop;
  }

  if(iex || nav)
  {
    skin.top=y+yyy;
    skin.left=x+Xoffset; 
  }

  if(n_6)
  {
    skin.top=(y+yyy)+"px";
    skin.left=x+Xoffset+"px";
  }    
  nudge(x);
}

// avoid edge overflow
function nudge(x)
{
  var extreme,overflow,temp;

  // right
  if(iex) extreme=(document.body.clientWidth-popwidth);
  if(n_6 || nav) extreme=(window.innerWidth-popwidth);

  if(parseInt(skin.left)>extreme)
  {
    overflow=parseInt(skin.left)-extreme;
    temp=parseInt(skin.left);
    temp-=overflow;
    if(nav || iex) skin.left=temp;
    if(n_6)skin.left=temp+"px";
  }

  // left
  if(parseInt(skin.left)<1)
  {
    overflow=parseInt(skin.left)-1;
    temp=parseInt(skin.left);
    temp-=overflow;
    if(nav || iex) skin.left=temp;
    if(n_6)skin.left=temp+"px";
  }
}

// Pop up 'area'
// write content & display
function popup(msg,bak,ancho)
{
  var content;
  popwidth = ancho;
  content = "<TABLE WIDTH='"+popwidth+"' BORDER='1' BORDERCOLOR="+bcolor+" CELLPADDING=2 CELLSPACING=0 "+"BGCOLOR="+bak+"><TD class='popup'>"+msg+"</TD></TABLE>";

  if(old)
  {
    alert(msg);
    return;
  } 
   
  yyy=Yoffset; 
  skin.width=popwidth;

  if(nav)
  { 
    skin.document.open();
    skin.document.write(content);
    skin.document.close();
    skin.visibility="visible";
  }

  if(iex)
  {        
    pup.innerHTML=content;
    skin.visibility="visible";
  }  

  if(n_6)
  {   
    document.getElementById("pup").innerHTML=content;
    skin.visibility="visible";
  }
}


// park content box
function kill()
{
  if(!old)
  {
    yyy=-1000;
    skin.visibility="hidden";
    skin.width=0;
  }
}
