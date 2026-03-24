/**
 * PhotoStore (PSO)
 * 
 * Powered by Processing
 * Presented by Group 1, Civil Engineering D2401, D2402
 * Tutored by Dr. Lin, Dr. Yuan, Dr. Li
 *
 **/
 
//****
//  The Reference was Declared in the Bottom of This Page !
//****

//***** 
//  The variaties could not set in the same place, I have tried it but, it could lead to some unknown wrong. T_T
//***** 


//The class of Buttons, to save their x, y, width, two lenth of it
//To avoid declare numerous varieties that may take a lot of room;
class Butt{
  int x, y;//The position x and y of the top left
  int w, h;//w:Width, h:height 
  int lenX, lenY;//Lenth
  
  Butt(int a, int b, int c, int d){
    x=a;
    y=b;
    w=c;
    h=d;                                                
    lenX=x+w;
    lenY=y+h;
  }
}

//All the buttons varieties are set here
/*
1.res:Resume
2.bak:Back->Withdraw
3.pn:Brush->Pen
0.cc:Cancel
4.er:Eraser
5.lft:Left(Minus -)
6.rit:Right(Plus +)
7.rttF:Rotate_FirstVerson
8.chs:Zoom->ChangeSize
9.chc:Change Color and Font Size
10.rttS:Rotate_SecondVerson ###(abolish this case)
11.typ:Type Characters
12.crp:Crop Images
13.brit:Change the Brightness
*/

boolean jud=false, typeMode=false, judIpt=false;
int typeX, typeY;//To save the position of texts that user inputs
int choice=0, preChoice=999;//To convey press whitch button 
int previewChoice=0;
int midX, midY;//The middle of paiting windows
//int imgMidX, imgMidY;//The middle of the image
int gapX, gapY;//Calculate the paiting area's gap from top to bottom
//int gapImgX, gapImgY;
int pImgW, pImgH;//The pervious weight and height of image 

//The main function
void draw(){
  //cover the proportion that out of the paiting window
  noStroke();
  fill(backCo);
  rect(0, 0, nowW, zoneStY);
  rect(0, 0, zoneStX, nowH);
  rect(zoneX1, 0, nowW-zoneX1, nowH);
  
  /*noStroke();
  background(backCo);*/
  //declare all the variaties
  Butt res, bak, pn, cc, er, lft, rit, rttF, rttS, chs, chc, typ, crp, brit;
  
  //give numbers to the varieties
  
  //caculate the outline of the paiting window
  zoneStX=nowH/25;
  zoneStY=nowH/6;
  zoneX1=nowW-nowW/10;
  zoneY1=zoneStY;
  zoneX2=zoneStX;
  zoneY2=nowH-nowH/17;
  zoneX3=zoneX1;
  zoneY3=zoneY2;
  
  midX=(zoneStX+zoneX1)/2;
  midY=(zoneStY+zoneY2)/2;
  
  gapX=zoneX1-zoneStX;
  gapY=zoneY2-zoneStY;
  
  int nowH_div=nowH/7;//calculate the button size in advance to avoid more calculation
  //println(nowW);println(nowW/150);println(nowW/10);println(nowW/5);println(nowW/2);println("--------");
  res=new Butt(nowW/150, nowH/150, nowH_div, nowH_div);
  bak=new Butt(nowW/10, nowH/150, nowH_div, nowH_div);
  pn=new Butt(nowW/5, nowH/150, nowH_div, nowH_div);
  cc=new Butt(int(nowW/1.1), zoneStY, nowH_div, nowH_div);
  er=new Butt(int(nowW/3.35), nowH/150, nowH_div, nowH_div);
  lft=new Butt(int(nowW/1.55), nowH/150, nowH_div, nowH_div);
  rit=new Butt(int(nowW/1.25), nowH/150, nowH_div, nowH_div);
  rttF=new Butt(int(nowW/1.1), int(nowH/3.1), nowH_div, nowH_div);
  //rttS=new Butt(int(nowW/1.1), int(nowH/1.9), nowH_div, nowH_div);
  chs=new Butt(int(nowW/1.1), int(nowH/2.1), nowH_div, nowH_div);
  chc=new Butt(int(nowW/1.1), zoneY2-nowH/7, nowH_div, nowH_div);
  typ=new Butt(int(nowW/2.55), nowH/150, nowH_div, nowH_div);
  crp=new Butt(int(nowW/1.1), int(nowH/1.6), nowH_div, nowH_div);
  brit=new Butt(int(nowW/2.05), nowH/150, nowH_div, nowH_div);
  
  //display all the buttons on the main windows
  image(callRes, res.x, res.y, res.w, res.h);//Resume
  image(back, bak.x, bak.y, bak.w, bak.h);//Withdraw
  image(pen, pn.x, pn.y, pn.w, pn.h);//Brush
  image(canc, cc.x, cc.y, cc.w, cc.h);//Cancle
  image(eras, er.x, er.y, er.w, er.h);//Eraser
  image(left, lft.x, lft.y, lft.w, lft.h);//Left(minus)
  image(right, rit.x, rit.y, rit.w, rit.h);//Right(plus)
  image(rottFst, rttF.x, rttF.y, rttF.w, rttF.h);//First_Rotate
  //image(rottSnd, rttS.x, rttS.y, rttS.w, rttS.h);
  image(chgeSz, chs.x, chs.y, chs.w, chs.h);//Change the size of image
  image(chgeCo, chc.x, chc.y, chc.w, chc.h);//Change the brush color, strokeWeight and font Size
  image(typeTxt, typ.x, typ.y, typ.w, typ.h);//Type texts
  image(crop, crp.x, crp.y, crp.w, crp.h);//Crop images
  image(bright, brit.x, brit.y, brit.w, brit.h);//Change the brightness
  
  //Pait tips
  makeSent(choice);
  preview(preChoice);
  
  //Paiting the outline
  stroke(#050505);
  strokeWeight(2);
  
  line(zoneStX, zoneStY, zoneX1, zoneY1);
  line(zoneStX, zoneStY, zoneX2, zoneY2);
  line(zoneX1, zoneY1, zoneX3, zoneY3);
  line(zoneX2, zoneY2, zoneX3, zoneY3);
  
  //the preview of functions
  if(mouseX>res.x&&mouseX<res.lenX&&mouseY>res.y&&mouseY<res.lenY){//Resume
    preChoice=1;
  }
  else if(mouseX>bak.x&&mouseX<bak.lenX&&mouseY>bak.y&&mouseY<bak.lenY){//Withdraw
    preChoice=2;
  }
  else if(mouseX>pn.x&&mouseX<pn.lenX&&mouseY>pn.y&&mouseY<pn.lenY){//Brush
    preChoice=3;
  }
  else if(mouseX>cc.x&&mouseX<cc.lenX&&mouseY>cc.y&&mouseY<cc.lenY){//Cancle
    preChoice=0; 
  }
  else if(mouseX>er.x&&mouseX<er.lenX&&mouseY>er.y&&mouseY<er.lenY){//Eraser
    preChoice=4;
  }
  else if(mouseX>lft.x&&mouseX<lft.lenX&&mouseY>lft.y&&mouseY<lft.lenY){//Left(minus)
    preChoice=5;
  }
  else if(mouseX>rit.x&&mouseX<rit.lenX&&mouseY>rit.y&&mouseY<rit.lenY){//Right(plus)
    preChoice=6;
  }
  else if(mouseX>rttF.x&&mouseX<rttF.lenX&&mouseY>rttF.y&&mouseY<rttF.lenY){//Rotate
    preChoice=7;
  }
  else if(mouseX>chs.x&&mouseX<chs.lenX&&mouseY>chs.y&&mouseY<chs.lenY){//Zoom
    preChoice=8;
  }
  else if(mouseX>chc.x&&mouseX<chc.lenX&&mouseY>chc.y&&mouseY<chc.lenY){//Change color and size    
    preChoice=9;
  }
  else if(mouseX>typ.x&&mouseX<typ.lenX&&mouseY>typ.y&&mouseY<typ.lenY){//Typing
    preChoice=11;
  }
  else if(mouseX>crp.x&&mouseX<crp.lenX&&mouseY>crp.y&&mouseY<crp.lenY){//Crop
    preChoice=12;
  }
  else if(mouseX>brit.x&&mouseX<brit.lenX&&mouseY>brit.y&&mouseY<brit.lenY){//Brightness
    preChoice=13;
  }
  else{
    preChoice=999;
  }
  
  //The proportion of interaction
  if(mousePressed==true&&mouseButton==LEFT){
    if(mouseX>res.x&&mouseX<res.lenX&&mouseY>res.y&&mouseY<res.lenY){//Click the Resume
      newRes();
 
      choice=1;
    }
    else if(mouseX>bak.x&&mouseX<bak.lenX&&mouseY>bak.y&&mouseY<bak.lenY){//Click the Withdraw
      backData();
    
      choice=2;
    }
    else if(mouseX>pn.x&&mouseX<pn.lenX&&mouseY>pn.y&&mouseY<pn.lenY){//Click the Brush
      choice=3;
    }
    else if(mouseX>cc.x&&mouseX<cc.lenX&&mouseY>cc.y&&mouseY<cc.lenY){//Click the Cancle
      choice=0; 
    }
    else if(mouseX>er.x&&mouseX<er.lenX&&mouseY>er.y&&mouseY<er.lenY){//Click the Eraser
      choice=4;
    }
    else if(mouseX>lft.x&&mouseX<lft.lenX&&mouseY>lft.y&&mouseY<lft.lenY){//Click the Left
      if(choice==7){
        preChoice=7;
        choice=5;
      }
      else if(choice==8){
        preChoice=8;
        choice=5;
      }
      else if(choice==13){
        preChoice=13;
        choice=5;
      }
    }
    else if(mouseX>rit.x&&mouseX<rit.lenX&&mouseY>rit.y&&mouseY<rit.lenY){//Click the Right
      if(choice==7){
        preChoice=7;
        choice=6;
      }    
      else if(choice==8){
        preChoice=8;
        choice=6;
      }
      else if(choice==13){
        preChoice=13;
        choice=6;
      }
    }
    else if(mouseX>rttF.x&&mouseX<rttF.lenX&&mouseY>rttF.y&&mouseY<rttF.lenY){//Click the Rotate
      choice=7;
    }
    else if(mouseX>chs.x&&mouseX<chs.lenX&&mouseY>chs.y&&mouseY<chs.lenY){//Click the Zoom
      choice=8;
    }
    else if(mouseX>chc.x&&mouseX<chc.lenX&&mouseY>chc.y&&mouseY<chc.lenY){//Click the palette
      newCoRes();
      
      choice=9;
    }
    else if(mouseX>typ.x&&mouseX<typ.lenX&&mouseY>typ.y&&mouseY<typ.lenY){//Click the Typing
      choice=11;
    }
    else if(mouseX>crp.x&&mouseX<crp.lenX&&mouseY>crp.y&&mouseY<crp.lenY){//Click the Crop
      choice=12;
    }
    else if(mouseX>brit.x&&mouseX<brit.lenX&&mouseY>brit.y&&mouseY<brit.lenY){//Click the Brightness
      choice=13;
    }
  } 
  
  //Input the image
   if(img!=null){
    int imgW=img.width,imgH=img.height;
    
    if(judIpt==true){
      for(int i=1; ; ++i){//To avoid the image go out of the paiting area
        if(imgW<gapX&&imgH<gapY){
          break;
        }
    
        imgW/=i;
        imgH/=i;
      }
      
      judIpt=false;
    } 
       
    image(img, (zoneStX+(gapX-imgW))/2, (zoneStY+(gapY-imgH))/2, imgW, imgH);
    
    saveData();//Save and output
    
    img=null;//Input once to avoid inputting again and again
  }
  
  //操作
  if(choice!=9){//Without clicing the palette, choiceRGB would be 0, to avaiod it could not click again
    choiceRGB=0;
  }
  
  switch (choice){
    case 3:
      usePen(R, G, B, bruSize);//Pen
      break;
    case 4:
      usePen(255, 255, 255, 35);//Eraser, actually white pen (XD)
      break;
    case 5://Left
      if(preChoice==7){//Rotate
        rotateLeft(); 
      }
      else if(preChoice==8){//Zoom
        smaller();        
        //println("larger");
      }
      else if(preChoice==13){//Brightness darker
        //println("-");
        chgBri(0.9);
      }      
      break;
    case 6://右
      if(preChoice==7){//Rotate
        rotateRight();
      }
      else if(preChoice==8){//Zoom
        larger();
        //println("smaller");
      }
      else if(preChoice==13){//Brightness brighter
        //println("+");
        chgBri(1.1);
      }     
      break;
    case 11://Type the texts
      if(mousePressed==true&&mouseButton==LEFT&&mouseX>zoneStX&&mouseX<zoneX1&&mouseY>zoneStY&&mouseY<zoneY2){//Typing mode
        typeSave();//Save the first situation
      
        typeMode=true;//Change to the mode of typing
        typeX=mouseX;
        typeY=mouseY;
        preChoice=choice;//If start typing, you must press ENTER to over it
      }
    case 12://Crop
      cropIMG();
      break;
  }
  
  if(typeMode==true){//Typing mode
    choice=preChoice;//If start typing, you must press ENTER to over it
    
    typeChar(mouseX, mouseY);
  }
}

/**
 * Reference 
 * 
 *
 * Processing Official Website:  https://processing.org/, to get some Functions and Libraries
 * CNBLOGS: https://www.cnblogs.com/sharpeye/p/14655291.html, to generate a new window
 * LAB-Z: https://www.lab-z.com/procinput/, to relize typing function
 * Zhaicool: https://web.zhaicool.net/1014.html, to learn the RGB
 * CSDN: https://blog.csdn.net/Sharon_zhugecat/article/details/135532419, to learn the pixels of images
 * CSDN: https://blog.csdn.net/zd623949282/article/details/107345698, to learn the pixels of images
 * Ali Cloud: https://developer.aliyun.com/article/120644, to learn how to input
 * GuideBook: Processing Creative Programming and Interaction Design(Processing Chuang Yi Bian Cheng yu Jiao Hu She Ji)
 * Bilibili: https://www.bilibili.com/video/BV19y4y1Y7EC/?spm_id_from=333.337.search-card.all.click&vd_source=297f3b6374d0c142d4be74428411dff4
 * Bilibili: https://www.bilibili.com/video/BV1Kt4y1y7LP/?spm_id_from=333.337.search-card.all.click
 * Bilibili: https://www.bilibili.com/video/BV19v411i7G2/?spm_id_from=333.337.search-card.all.click
 * Bilibili: https://www.bilibili.com/video/BV1HG4y1R71v/?vd_source=297f3b6374d0c142d4be74428411dff4
 * Bilibili: https://www.bilibili.com/video/BV14o4y1375x/?spm_id_from=333.337.search-card.all.click
 *
 *** NO AI ASSISTANCE ***
**/
