//Initial & Setting Page

/*
Functions that Realized:
1.Call up the resume
2.Change the size of the software windows, and maintain the correct position (Windows and FullScreen)
3.Input and output the images
5.Function of void setup();
*/

int w1, h1,//FullScreen
    w2, h2;//Window
int nowW=w2, nowH=h2;//Now window size
int backCo=255;//Background Size
//final int slopeWin=2551;//1920*1080 Pythagorean                
          
int fontSize=20, userFontSize=20;//fontSize of software, and fontSize from users' text
int bruSize=3;//BrushSize
String loc;//location of image

PFont font;
PImage img;//input img
PImage logo, callRes, chgeSc, ipt, opt, back, pen, canc, eras, left, right, rottFst, rottSnd, chgeSz, chgeCo, typeTxt, crop, gift, eggImg, bright, ipt2, tips;
PImage green, red, blue, yellow;
//LOGO callUpResume ChangeScreenSize InputImg OutputImg
//Withdraw:back Brush:Pen Cancel Eraser Left Right 
//RotateFirst/Second  ChangeSize
//typeTxt 裁剪crop
PApplet resume, eggWin;//the windows of resumes and colorfulEgg
//File folderMat=new File(dataPath("MATERIAL"));

void midWin(){//Maintain the corner position
  //int slope=sqrt(nowW*nowW+nowH*nowH);//windows Pythagorean  
  int w=(displayWidth-nowW)/2,//Calculate the position of software to Screen
      h=(displayHeight-nowH)/2;
    
  surface.setLocation(w, h);
}

void reSize(int a, int b){//Change the size of windows
   nowW=a;
   nowH=b;
   
   windowResize(nowW, nowH);
   
   midWin();
}


PImage imgOutline,//Outline of resume
       imgIpt, imgOpt,//Input and output buttons
       imgSize;//Rusume size
       
    
void colorfulEgg(){//Colorful egg
  if(eggWin==null){
    eggWin=new PApplet(){
      public void settings(){
        size(1920, 1080);
      }
      
      public void setup(){
        background(backCo);
      }
      
      public void draw(){
        image(eggImg, 0, 0, 1920, 1080);
      }
      
      public void exit(){     
        dispose();
        eggWin=null; 
      }
    };
    
    PApplet.runSketch(new String[] {"eggWin"}, eggWin);//Generate a window
  }
}

void newRes(){//Generate resume window
  if(resume==null){
    resume=new PApplet(){  
      int resW=425, resH=750;//resume width height
      
      public void settings(){
        size(425, 750);
      }
      
      public void setup(){      
        background(backCo);
      }
    
      public void draw(){
        image(tips, 20, 180, tips.width/1.05, tips.height/1.05);
        //image(imgOutline, 0, 0, width, height);//outline
        image(ipt, 35, 30, 175, 175);
        image(opt, 100, 320, 175, 175);
        image(chgeSc, 100, 500, 175, 175);
        image(gift, 300, 580, 175, 175);
        image(ipt2, 220, 30, 175, 175);
      }
      
      public void mousePressed(){
         if(mouseX>35&&mouseX<210&&mouseY>30&&mouseY<205){//Input          
            inPut();
         } 
         else if(mouseX>100&&mouseX<275&&mouseY>320&&mouseY<495){//Output
            outputPic();
         }
         else if(mouseX>100&&mouseX<275&&mouseY>500&&mouseY<675){//Full and window
           if(nowW==w1){
             reSize(w2, h2);
           }
           else{
             reSize(w1, h1);
           }
         }
         else if(mouseX>354&&mouseX<394&&mouseY>689&&mouseY<724){//colorful egg
           colorfulEgg();  
         }
         else if(mouseX>220&&mouseX<395&&mouseY>30&&mouseY<205){//colorful egg
           judIpt=true;
           
           inPut();
         }
      }
      
      public void exit(){
        choice=0; //choice=0，otherwise shutting down the resume it would display SETTINGS
        
        dispose();
        resume=null; 
      }
    };
  
    PApplet.runSketch(new String[] {"resume"}, resume);
  }
}

void inPut(){ 
  selectInput("Select", "inputPic");
}

void inputPic(File sel){//Input image
  //println(sel);
  if(sel!=null){//if chosen
      img=loadImage(sel.getAbsolutePath());//The location of image
  }
}

void outputPic(){//output
  PImage optIMG=get(zoneStX, zoneStY, gapX, gapY);//Capture the img from paiting area;
  optIMG.save("output.png");
}

void setup(){
   //initialize
   size(100, 100);
   background(backCo);
   textSize(fontSize);
   font=loadFont("Bahnschrift-12.vlw");
   
   //clear the outline and fillColor
   noStroke();
   noFill();
   
   //get the fullScreen size and windowScrren size
   w1=displayWidth;
   h1=displayHeight;
   w2=(int)(displayWidth/1.5);
   h2=(int)(displayHeight/1.5);
   
   //Default size is the windowScreen
   reSize(w2, h2);
   
   //the proportion of colorful egg
   eggImg=loadImage("data/MATERIAL/giftImg.png");
   
   //the proportion of resume
   //imgOutline=loadImage("data/MATERIAL/RESUME_Outline.png");
   callRes=loadImage("data/MATERIAL/RESUME_CallUp.png");
   chgeSc=loadImage("data/MATERIAL/RESUME_Screen.png");
   gift=loadImage("data/MATERIAL/RESUME_Gift.png");
   ipt=loadImage("data/MATERIAL/RESUME_InputIMG.png");
   ipt2=loadImage("data/MATERIAL/RESUME_InputIMG_2.png");
   opt=loadImage("data/MATERIAL/RESUME_OutputIMG.png");
   tips=loadImage("data/MATERIAL/RESUME_Tips.png");
   
   //The proportion of main windows
   logo=loadImage("data/MATERIAL/LOGO.png");   
   back=loadImage("data/MATERIAL/Back.png");
   pen=loadImage("data/MATERIAL/Pen.png");
   canc=loadImage("data/MATERIAL/Cancel.png");
   eras=loadImage("data/MATERIAL/Eraser.png");
   left=loadImage("data/MATERIAL/Left.png");
   right=loadImage("data/MATERIAL/Right.png");
   rottFst=loadImage("data/MATERIAL/Rotate_1.png");
   rottSnd=loadImage("data/MATERIAL/Rotate_2.png");
   chgeSz=loadImage("data/MATERIAL/ChangeSize.png");
   chgeCo=loadImage("data/MATERIAL/ChangeColor.png");
   typeTxt=loadImage("data/MATERIAL/TypeText.png");
   crop=loadImage("data/MATERIAL/Crop.png");
   bright=loadImage("data/MATERIAL/Brightness.png");
   
   //The proportion of palette
   //conf=loadImage(folderMat.getAbsoluteFile()+"/"+"Confirm.png");
   green=loadImage("data/MATERIAL/GreenParty.png");
   blue=loadImage("data/MATERIAL/HarryPotter.png");
   yellow=loadImage("data/MATERIAL/Minion.png");
   red=loadImage("data/MATERIAL/OnlyAppleCanDo.png");
   
   midWin();//Always keep the software to the middle of screen
}
