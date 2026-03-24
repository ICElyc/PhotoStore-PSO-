//Main Functions

/*
Functions that Realized:
1.Display the Mode now, and preview the mode
2.Brush
3.Withdraw, backup to the data->BACKUP
4.Left(minus) and right(plus)
5.Change size and rotate
6.Palette， default RGB:0, 0, 0  strokeWeight:3, Font Size:20 
7.Typing
*/

final int N=105;

int R=0, G=0, B=0;//Default RGB:0, 0, 0, means black
          
int zoneStX, zoneStY;//(x, y) StartX StartY
int zoneX1, zoneY1, zoneX2, zoneY2, zoneX3, zoneY3;//Outline, (x1, y1) (x2, y2)
int n=0;//To count the backups

PImage preData;//Get img from last one
PImage[] data=new PImage[N];//100 steps at most

//RGB blanks size 
int gapRGBX=100, gapRGBY=30;
        
//Position of blanks
int RX1=60, RX2=RX1+gapRGBX, RY1=60, RY2=RY1+gapRGBY;
int GX1=340, GX2=GX1+gapRGBX, GY1=60, GY2=GY1+gapRGBY;
int BX1=620, BX2=BX1+gapRGBX, BY1=60, BY2=BY1+gapRGBY;
int brX1=100, brX2=brX1+gapRGBX, brY1=625, brY2=brY1+gapRGBY;
int ftX1=550, ftX2=ftX1+gapRGBX, ftY1=625, ftY2=ftY1+gapRGBY;

int choiceRGB=0;//Default:0, means no options
int strlen=0;//Lenth of it
String userIpt="";//user typing content

PApplet resumeCo;//NewColorResume

void reset(){//Reset all the variaties of palette
  choiceRGB=0;
  strlen=0;
  userIpt="";  
}

void typeNum(int x1, int y1, int x2, int y2, int gX, int gY, PApplet rgbR){//Type numbers
  //println("bbb");
  int nX=x1+5, mY=(y1+y2)/2 +5;  
  
  //Cover the previous texts
  rgbR.noStroke();
  rgbR.fill(backCo);
  rgbR.rect(x1, y1, gapRGBX, gapRGBY);
  
  //if there are texts, display
  if(strlen>0){    
    rgbR.fill(#000000);
    
    rgbR.text(userIpt, nX, mY);
  }
}

Butt rd, blu, yel, gre;//Four default colors

void newCoRes(){//Generate a palette window
  if(resumeCo==null){
    resumeCo=new PApplet(){  
      int resW=550, resH=1000;//Width height
     
      public void settings(){
        size(1000, 800);
      }
      
      public void setup(){   
        float divN=1.5;
        
        rd=new Butt(50, 300, int(red.width/divN), int(red.height/divN));
        blu=new Butt(280, 300, int(blue.width/divN), int(blue.height/divN));
        yel=new Butt(510, 300, int(yellow.width/divN), int(yellow.height/divN));
        gre=new Butt(740, 300, int(green.width/divN), int(green.height/divN));
        
        background(backCo);   
        
        textSize(fontSize);
        
        image(red, rd.x, rd.y, rd.w, rd.h);
        image(blue, blu.x, blu.y, blu.w, blu.h);
        image(yellow, yel.x, yel.y, yel.w, yel.h);
        image(green, gre.x, gre.y, gre.w, gre.h);
        
        reset();
      }
    
      public void draw(){
        if(choiceRGB==0){
          //Blank Typing
          fill(#FF0000);
          text("R (0-255):", 20, 55);
        
          fill(#00FF00);
          text("G (0-255):", 300, 55);
        
          fill(#0000FF);
          text("B (0-255):", 580, 55);
          
          fill(#000000);
          text("Brush Thickness (0-200):", 20, 600);
          text("Font Size (0-50):", 500, 600);
          text("Default Color:", 20, 280);
        
          fill(backCo);
          strokeWeight(3);        
          rect(RX1, RY1, gapRGBX, gapRGBY);//R
          rect(GX1, GY1, gapRGBX, gapRGBY);//G
          rect(BX1, BY1, gapRGBX, gapRGBY);//B
          rect(brX1, brY1, gapRGBX, gapRGBY);//Stroke of brush
          rect(ftX1, ftY1, gapRGBX, gapRGBY);//Font size
        }
              
        switch(choiceRGB){
          case 1://R
            typeNum(RX1, RY1, RX2, RY2, gapRGBX, gapRGBY, this);
            break;
          case 2://G
            typeNum(GX1, GY1, GX2, GY2, gapRGBX, gapRGBY, this);
            break;
          case 3://B
            typeNum(BX1, BY1, BX2, BY2, gapRGBX, gapRGBY, this);
            break;           
          case 4://Stroke
            typeNum(brX1, brY1, brX2, brY2, gapRGBX, gapRGBY, this);
            break;
          case 5://Font size
            typeNum(ftX1, ftY1, ftX2, ftY2, gapRGBX, gapRGBY, this);
            break;
        }
        
        //Preview of RGB color
        noStroke();
        fill(R, G, B);
        
        circle(900, 100, 100);
      }
      
      public void mousePressed(){
         if(mouseX>RX1&&mouseX<RX2&&mouseY>RY1&&mouseY<RY2&&choiceRGB==0){//Click R blank
           //Cover previous RGB and other blanks
           noStroke();
           fill(backCo);
           
           rect(RX1, RY1, 1000, gapRGBY);
           rect(brX1, brY1, 1000, gapRGBY);
         
           //Click R blank and make others black
           stroke(#000000);
           strokeWeight(3);
           
           rect(GX1, GY1, gapRGBX, gapRGBY);//G
           rect(BX1, BY1, gapRGBX, gapRGBY);//B
           rect(brX1, brY1, gapRGBX, gapRGBY);
           rect(ftX1, ftY1, gapRGBX, gapRGBY);
           
           
           //R blank comes to RED
           stroke(#FF0000);
           rect(RX1, RY1, gapRGBX, gapRGBY);
           
           choiceRGB=1;//R
         }
         else if(mouseX>GX1&&mouseX<GX2&&mouseY>GY1&&mouseY<GY2&&choiceRGB==0){//点击G框
           //click G blank then make R, B blank black
           noStroke();
           fill(backCo);           
           
           rect(RX1, RY1, 1000, gapRGBY);
           rect(brX1, brY1, 1000, gapRGBY);
           
           stroke(#000000);
           strokeWeight(3);
           
           rect(RX1, RY1, gapRGBX, gapRGBY);//R
           rect(BX1, BY1, gapRGBX, gapRGBY);//B
           rect(brX1, brY1, gapRGBX, gapRGBY);
           rect(ftX1, ftY1, gapRGBX, gapRGBY);
           
           //G blank comes to GREEN
           stroke(#00FF00);
           rect(GX1, GY1, gapRGBX, gapRGBY);
           
           choiceRGB=2;//G
         }
         else if(mouseX>BX1&&mouseX<BX2&&mouseY>BY1&&mouseY<BY2&&choiceRGB==0){//click B blank
           //B blank comes to BLUE
           noStroke();
           fill(backCo); 
           
           rect(RX1, RY1, 1000, gapRGBY);
           rect(brX1, brY1, 1000, gapRGBY);
           
           stroke(#000000);
           strokeWeight(3);
           
           rect(RX1, RY1, gapRGBX, gapRGBY);//R
           rect(GX1, GY1, gapRGBX, gapRGBY);//G
           rect(brX1, brY1, gapRGBX, gapRGBY);
           rect(ftX1, ftY1, gapRGBX, gapRGBY);
           
           //B blank becomes blue
           stroke(#0000FF);
           rect(BX1, BY1, gapRGBX, gapRGBY);
           
           choiceRGB=3;//B
         }
         else if(mouseX>brX1&&mouseX<brX2&&mouseY>brY1&&mouseY<brY2&&choiceRGB==0){//Change the stroke
           noStroke();
           fill(backCo); 
           
           rect(RX1, RY1, 1000, gapRGBY);
           rect(brX1, brY1, 1000, gapRGBY);
           
           stroke(#000000);
           strokeWeight(3);
           
           rect(RX1, RY1, gapRGBX, gapRGBY);//R
           rect(GX1, GY1, gapRGBX, gapRGBY);//G
           rect(BX1, BY1, gapRGBX, gapRGBY);//B 
           rect(ftX1, ftY1, gapRGBX, gapRGBY);//Font size
           
           stroke(R, G, B);
           rect(brX1, brY1, gapRGBX, gapRGBY);
           
           choiceRGB=4;
         }
         else if(mouseX>ftX1&&mouseX<ftX2&&mouseY>ftY1&&mouseY<ftY2&&choiceRGB==0){//Change font size
           noStroke();
           fill(backCo); 
           
           rect(RX1, RY1, 1200, gapRGBY);
           rect(brX1, brY1, 1200, gapRGBY);
           
           stroke(#000000);
           strokeWeight(3);
           
           rect(RX1, RY1, gapRGBX, gapRGBY);//R
           rect(GX1, GY1, gapRGBX, gapRGBY);//G
           rect(BX1, BY1, gapRGBX, gapRGBY);//B 
           rect(brX1, brY1, gapRGBX, gapRGBY);//Bursh stroke
           
           stroke(R, G, B);
           rect(ftX1, ftY1, gapRGBX, gapRGBY);
           
           choiceRGB=5;
         }
         else if(mouseX>rd.x&&mouseY>rd.y&&mouseX<rd.lenX&&mouseY<rd.lenY&&choiceRGB==0){//Red
           R=234;
           G=74;
           B=73;
         }
         else if(mouseX>yel.x&&mouseY>yel.y&&mouseX<yel.lenX&&mouseY<yel.lenY&&choiceRGB==0){//Yellow
           R=247;
           G=207;
           B=86;
         }
         else if(mouseX>gre.x&&mouseY>gre.y&&mouseX<gre.lenX&&mouseY<gre.lenY&&choiceRGB==0){//Green
           R=118;
           G=209;
           B=119;
         }
         else if(mouseX>blu.x&&mouseY>blu.y&&mouseX<blu.lenX&&mouseY<blu.lenY&&choiceRGB==0){//Blue
           R=65;
           G=141;
           B=241;
         }
      }
      
      public void keyPressed(){
        textSize(fontSize);
        
        if(choiceRGB!=0){
          if(keyCode==BACKSPACE&&strlen>0){//Delete preText
            userIpt=userIpt.substring(0, strlen-1);
            strlen--;
          }
          else if(key>='0'&&key<='9'){//Type 1-9 only
            //println("aaa");
            userIpt+=key;
            strlen++;
          }               
          else if(keyCode==ENTER){//Press ENTER
            if(userIpt!=""){
              //Judge if the input number is legal
              int numb=Integer.parseInt(userIpt);//Translate String to Int
            
              if(choiceRGB==1||choiceRGB==2||choiceRGB==3){
                if(numb<0||numb>255){//RGB only legal from 0 to 255
                  reset();
                }
              }
              else if(choiceRGB==4){
                if(numb<0||numb>200){//Stroke only legal from 0 to 200
                  numb=3;
                }
              }
              else if(choiceRGB==5){
                if(numb<0||numb>50){//Font Size only legal from 0 to 20
                  numb=20;
                }
              }
                
              switch (choiceRGB){
                case 1://R
                  R=numb;
                  
                  reset();//Reset the string to get next one
                  break;
                case 2://G
                  G=numb;
              
                  reset();
                  break;
                case 3://B
                  B=numb;
              
                  reset();
                  break;
                case 4://Stroke
                  bruSize=numb;                 
              
                  reset();
                  break;
                case 5://Font Size
                  userFontSize=numb;                 
              
                  reset();
                  break;
              }
            }
            else{
              reset();
            }         
          }  
        }     
      }
      
      public void exit(){
        choice=0; //choice->preChoice to avoid display coloroptions always
        
        dispose();
        resumeCo=null; 
      }
    };
  
    PApplet.runSketch(new String[] {"resumeCo"}, resumeCo);
  }
}

File folderBkup=new File(dataPath("BACKUP"));

void saveData(){//Save all the step(but 100 at most)
  n++;

  if(n>100){
    n=1;
  }
  
  if(folderBkup.exists()==false){
    folderBkup.mkdirs();
  }
  
  data[n]=get(zoneStX, zoneStY, gapX, gapY);//Get the image from paiting area
  data[n].save(folderBkup.getAbsoluteFile()+"/"+"save"+nf(n, 3)+".png"); 
}

void backData(){//Withdraw
  if(n!=0){//n=0 means no options
    //println("11111");println(zoneStX);println(zoneStY);    
    fill(#FFFFFF);
    rect(zoneStX, zoneStY, gapX, gapY);

    if(n==1){//n=1 means only one step，withdraw=become blank
      return;
    }

    n--;
  
    preData=loadImage(folderBkup.getAbsoluteFile()+"/"+"save"+nf(n, 3)+".png");//Get preStep image
  
    image(preData, zoneStX, zoneStY, gapX, gapY);//Display
  }
}

PImage typeImg;

void typeSave(){//save the preImage 
  typeImg=get(zoneStX, zoneStY, gapX, gapY);//Get the image from paiting area 
  typeImg.save("typeBackup.png"); 
}

void iniText(){//Reset the typing function
  choice=0;
  strlen=0;
  userIpt="";
  typeMode=false;
}

void typeChar(int x, int y){//To realize the function of typing the texts on the paiting area
  textSize(userFontSize);

  if(mouseX>zoneStX&&mouseX<zoneX1&&mouseY>zoneStY&&mouseY<zoneY2){
    textSize(userFontSize);
    //Display texts
    if(strlen>0){
      image(typeImg, zoneStX, zoneStY, gapX, gapY);
      text(userIpt, x, y);  
    }
  
    if(keyPressed==true){
        //println(strlen);
        if(key==8&&strlen>0){//Delete last character and judge if it could be deleted again
          //println("111");
          userIpt=userIpt.substring(0, strlen-1);     
          strlen--;
          
          backData();//Withdraw
        }
        else if((key>='0'&&key<='9')||(key>='a'&&key<='z')||(key>='A'&&key<='Z')/*||(key>=32&&key<=47)*/){//Only 0-9 a-z A-Z
          //println("222");
          userIpt+=key;
          strlen++;
                   
          delay(15);
        
          saveData();//Backup if typing
        }
        else if(key==10||key==13){//Confirm
          //println("333");
          image(typeImg, zoneStX, zoneStY, gapX, gapY);
          text(userIpt, x, y); 
        
          saveData();//Backup
        
          iniText();//Initialize
        }
    }
  } 
}


boolean judPen=false;
float pX, pY;//previousX previousY

void usePen(int a, int b, int c, int w){//a, b, c, w means R G B stroke, respectively
  stroke(a, b, c);
  strokeWeight(w);
  
  //println(zoneStX);println(zoneStY);println(zoneX1);println(zoneY2);
  
  if(mouseX>zoneStX&&mouseX<zoneX1&&mouseY>zoneStY&&mouseY<zoneY2){//
    if(mousePressed==true&&mouseButton==LEFT){
      line(mouseX, mouseY, pX, pY);  
      
      judPen=false;
    }
    
    pX=mouseX;
    pY=mouseY;
  } 
  
  if(judPen==false){
     saveData();
     
     judPen=true;
  } 
}

boolean rL=false, rR=false;
float ang=0, dimLar=1, dimSma=1;//Angle dimention 
PImage rttIMG;//Image to rotate

void screenCap(){//Capture the image to realize the rotate and zoom
  rttIMG=get(zoneStX+5, zoneStY+5, gapX-10, gapY-10);
  
  //rttIMG=get(zoneStX+20, zoneStY+20, gapX-30, gapY-30);
  //rttIMG.save("saveIMG.png"); 
}
//println(zoneStX);println(zoneStY);println(gapX);println(gapY);

void rotateLeft(){//Rotate left
  if(rR==true){
    ang=0;
    rR=false;
  }
  
  rL=true;
  ang-=0.01;
  
  screenCap();
  
  noStroke();
  fill(backCo);
  rect(zoneStX, zoneStY, gapX, gapY);
  
  pushMatrix();
  
  translate(midX, midY);
  imageMode(CENTER);
  rotate(ang);
  
  image(rttIMG, 0, 0, gapX-10, gapY-10);
  
  saveData();
  
  popMatrix();
  imageMode(CORNER);
}

void rotateRight(){//Rotate right
  if(rL==true){
    ang=0;
    rL=false;
  }
  
  rR=true;
  ang+=0.01;
 
  screenCap();
  
  noStroke();
  fill(backCo);
  rect(zoneStX, zoneStY, gapX, gapY);
  
  pushMatrix();
  
  translate(midX, midY);
  imageMode(CENTER);
  rotate(ang);
  
  image(rttIMG, 0, 0, gapX-10, gapY-10);
  
  saveData();
  
  popMatrix();
  imageMode(CORNER);
  //rotate(0);
}

void larger(){//Larger
  dimLar+=0.01;
  
  screenCap();
    
  noStroke();
  fill(backCo);
  rect(zoneStX, zoneStY, gapX, gapY);
  
  imageMode(CENTER);
  
  image(rttIMG, midX, midY, (gapX)*dimLar, (gapY)*dimLar);
  
  imageMode(CORNER);
  
  saveData();
}

void smaller(){//Smaller
  dimSma+=0.01;

  screenCap();
    
  noStroke();
  fill(backCo);
  rect(zoneStX, zoneStY, gapX, gapY);
  
  imageMode(CENTER);
  
  image(rttIMG, midX, midY, (gapX)/dimSma, (gapY)/dimSma);
  
  imageMode(CORNER);
  
  saveData();
}

boolean fstTap=false, sndTap=false;//Judge if the first click and the second click finished
int x1, y1, x2, y2;
PImage cIMG;

void maxN(){//Ensure x1, x2, y1, y2 in correct position to avoid nagtive answer
  int temp;
  
  if(x1>x2){
    temp=x2;
    x2=x1;
    x1=temp;
  }
  if(y1>y2){
    temp=y2;
    y2=y1;
    y1=temp;
  }
}

void iniCrop(){
   x1=0;
   y1=0;
   x2=0;
   y2=0;
   fstTap=false;
   sndTap=false;
}

void cropCap(int x1, int y1, int x2, int y2){
  cIMG=get(x1, y1, x2-x1, y2-y1);
  
  fill(backCo);
  rect(zoneStX, zoneStY, gapX, gapY);
  
  println(x1);println(y1);println(x2);println(y2);
  image(cIMG, x1, y1, x2-x1, y2-y1);
}

void cropIMG(){//Crop
  if(sndTap==false){//If the second click finished
    if(mousePressed==true&&mouseButton==LEFT&&mouseX<zoneX1&&mouseY>zoneStY&&mouseY<zoneY2){
      if(fstTap==false){//First clicked
        x1=mouseX;
        y1=mouseY;      
        fstTap=true;
      }
      else{
        x2=mouseX;
        y2=mouseY;
        sndTap=true;
      }
    }
  }
  else{
    saveData();
    
    maxN();
    
    cropCap(x1, y1, x2, y2);
    
    iniCrop();
  }  
  
  delay(50);  
}

PImage brImg;//Get the image of paiting area to change the brightness

void chgBri(float num){//Change brightness
  saveData();
  
  brImg=get(zoneStX, zoneStY, gapX, gapY);
  
  brImg.loadPixels();
  
  for(int i=0; i<gapX; ++i){//Run over all the pixels in the paiting area
     for(int j=0; j<gapY; ++j){
       int ind=i+j*gapX;//Get the index from the array  
       color c=brImg.pixels[ind];//Get the color of this pixel
       
       float r= red(c), g=green(c), b=blue(c);
       
       //Change the brightness
       r=constrain(r*num, 0, 255);
       g=constrain(g*num, 0, 255);
       b=constrain(b*num, 0, 255);
       
       brImg.pixels[ind]=color(r, g, b);
     }
  }
  
  brImg.updatePixels();
  
  image(brImg, zoneStX, zoneStY, gapX, gapY);
}

void makeSent(int cho){//Tips
  int fontX=zoneStX, fontY=nowH-nowH/25+5;
  
  textSize(fontSize);
  noStroke();
  fill(#FFFFFF);
  rect(zoneStX, zoneY2, nowW, 500);//Cover previous sentences
  fill(#000000);
  
  switch (cho){
    case 0:
      text("NOW MODE: NULL", fontX, fontY);
      break;
    case 1:
      text("NOW MODE: SETTING", fontX, fontY);
      break;
    case 2:
      text("NOW MODE: WITHDRAW", fontX, fontY);
      
      choice=0;
      break;
    case 3:
      text("NOW MODE: PEN", fontX, fontY);
      break;
    case 4:
      text("NOW MODE: ERASER", fontX, fontY);
      break;
    case 5:
      text("NOW MODE: LEFT", fontX, fontY);
      
      choice=preChoice;
      break;
    case 6:
      text("NOW MODE: RIGHT", fontX, fontY);
      
      choice=preChoice;
      break;
    case 7:
      text("NOW MODE: ROTATE", fontX, fontY);
      break;
    case 8:
      text("NOW MODE: CHANGE SIZE", fontX, fontY);
      break;
    case 9:
      text("NOW MODE: PAITING OPTIONS", fontX, fontY);
    
      preChoice=choice;
      break;
    case 11:
      text("NOW MODE: TEXT TYPING", fontX, fontY);
      break;
    case 12:
      text("NOW MODE: CROP(Click Two Position!)", fontX, fontY);
      break;
    case 13:
      text("NOW MODE: CHANGE BRIGHTNESS", fontX, fontY);
      break;
  }
}

void preview(int cho){
  int fontX=zoneStX+500, fontY=nowH-nowH/25+5;
  
  /*textSize(fontSize);
  noStroke();
  fill(#FFFFFF);
  rect(zoneStX, zoneY2+5, 1000, 500);
  fill(#000000);*/
  
  switch (cho){
    case 999:
      text("MODE PREVIEW: NULL", fontX, fontY);
      break;
    case 0:
      text("MODE PREVIEW: CANCEL THE CHOICE", fontX, fontY);
      break;
    case 1:
      text("MODE PREVIEW: SETTING", fontX, fontY);
      break;
    case 2:
      text("MODE PREVIEW: WITHDRAW", fontX, fontY);
      break;
    case 3:
      text("MODE PREVIEW: PEN", fontX, fontY);
      break;
    case 4:
      text("MODE PREVIEW: ERASER", fontX, fontY);
      break;
    case 5:
      text("MODE PREVIEW: LEFT(MINUS -)", fontX, fontY);
      break;
    case 6:
      text("MODE PREVIEW: RIGHT(PLUS +)", fontX, fontY);
      break;
    case 7:
      text("MODE PREVIEW: ROTATE", fontX, fontY);
      break;
    case 8:
      text("MODE PREVIEW: CHANGE SIZE", fontX, fontY);
      break;
    case 9:
      text("MODE PREVIEW: PAITING OPTIONS", fontX, fontY);
      break;
    case 11:
      text("MODE PREVIEW: TEXT TYPING", fontX, fontY);
      break;
    case 12:
      text("MODE PREVIEW: CROP", fontX, fontY);
      break;
    case 13:
      text("MODE PREVIEW: CHANGE BRIGHTNESS", fontX, fontY);
      break;
  }
}
