package;
import Song.SwagSong; 
//yeyeyeyeyeye
import flixel.FlxG; 
//yeyeyeyeyeye
import flixel.FlxSprite; 
//yeyeyeyeyeye

//yeyeyeyeyeye
import flixel.tweens.FlxTween;
//yeyeyeyeyeye
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup.FlxTypedGroup; 
import flixel.text.FlxText; 
import flixel.util.FlxColor; 
import flixel.effects.FlxFlicker; 
import flixel.util.FlxTimer;

//yeyeyeyeyeye
import flixel.FlxObject;
//yeyeyeyeyeye
import flixel.addons.display.FlxBackdrop;
import flixel.graphics.frames.FlxAtlasFrames; 
import Section.SwagSection;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.math.FlxMath;
import MainMenuState;


class CharacterState extends MusicBeatState
{
	

	var menuItems:Array<String> = ['BOYFRIEND', 'PARAPPA'];
	//var bfMode:Array<String> = ['bf', 'bf-two', 'bf-three'];
	//var suffixArray:Array<String> = ['', '-two', '-three'];
	var curSelected:Int = 0;
	var canSelect:Bool = true;
	var txtDescription:FlxText;
	var boyfriends:FlxTypedGroup<SelectSprite>;
	var menuBG:FlxSprite;
	//var icons:FlxTypedGroup<FlxSprite>;
	public static var storyMode:Bool = false;
	var selectedCharPriv:Array<String> = ['bf', 'parappa'];
	public static var selectedChar:String;
	private var camFollow:FlxObject;
	var checkers:FlxBackdrop;
	var bf1Color:FlxColor = FlxColor.fromRGB(44, 173, 219);
	var bf2Color:FlxColor = FlxColor.fromRGB(242, 193, 46);
	var bf3Color:FlxColor = FlxColor.fromRGB(214,6,0);
	var alreadySelectedShit:Bool = false;
	var canSelectLeft:Bool = true;
	var canSelectRight:Bool = true;
	//var tex:FlxAtlasFrames;
	

	//var shittyNames:Array<String> = CoolUtil.coolTextFile('assets/preload/data/boyfriendnames.txt');
		
	

	var txtOptionTitle:FlxText;

	override function create()
	{


		
	//	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
		//	{
		//		tex = Paths.getSparrowAtlas('charMenu');
		//		frames = tex;
		//		animation.addByPrefix('bf idle pose', 'bf idle', 24, false);

		trace('this loaded 0000');







		camFollow = new FlxObject(0, 0, 1, 1);

	
		menuBG = new FlxSprite().loadGraphic(Paths.image('menuBGChar'));
		menuBG.color = menuBG.color;
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		menuBG.scrollFactor.set(0,0);
		add(menuBG);

		//checkers =  new FlxBackdrop("assets/images/charSelect/checkers.png",0,0,true,true);
		//checkers.screenCenter();
		//add(checkers);
		//FlxTween.tween(checkers,{x : 2, y : 2},24, {type:LOOPING});

	
		txtDescription = new FlxText(FlxG.width * 0.075, menuBG.y + 200, 0, "", 32);
		txtDescription.alignment = CENTER;
		txtDescription.setFormat("assets/fonts/vcr.ttf", 32);
		txtDescription.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1.5, 1);
		txtDescription.color = FlxColor.WHITE;
		txtDescription.scrollFactor.set(0,0);
		add(txtDescription);

	


		boyfriends = new FlxTypedGroup<SelectSprite>();
		add(boyfriends);
		//icons = new FlxTypedGroup<FlxSprite>();
		//add(icons);

		for (i in 0...menuItems.length){
				var boyfriend:SelectSprite = new SelectSprite(1200 *i, 170, menuItems[i]);
				boyfriend.scrollFactor.set(1,0);
				boyfriends.add(boyfriend);

				//var icon:FlxSprite = new FlxSprite(100 + (1200 * i), 200);
				//icon.frames = FlxAtlasFrames.fromSparrow('assets/preload/images/selectMenus/charMenuIcons.png', 'assets/preload/images/selectMenus/charMenuIcons.xml');
				//icon.antialiasing = true;
				//icon.ID = i;
				//icon.animation.addByPrefix('boyfriendIcon', 'bf idle', 1);
				//icon.animation.addByPrefix('parappaIcon', 'parappa idle', 1);
				//icon.animation.play(menuItems[i]);
				//add(icon);
				//icons.add(icon);

			}

		
		camFollow.x = boyfriends.members[0].getMidpoint().x;

		var charSelHeaderText:Alphabet = new Alphabet(0, 50, 'CHARACTER SELECT', true, false);
		charSelHeaderText.screenCenter(X);
		charSelHeaderText.scrollFactor.set(0,0);
		add(charSelHeaderText);
		trace('this loaded2');


		var selectionArrows:FlxSprite = new FlxSprite().loadGraphic(Paths.image('gameSelect/arrowsz'));
		selectionArrows.screenCenter();
		selectionArrows.antialiasing = true;
		selectionArrows.scrollFactor.set(0,0);
		add(selectionArrows);

		txtOptionTitle = new FlxText(FlxG.width * 0.7, 10, 0, "dfgdfgdg", 32);
		txtOptionTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtOptionTitle.alpha = 0.7;
		txtOptionTitle.scrollFactor.set(0,0);
		add(txtOptionTitle);

		changeSelection();


		super.create();
	}

	override function update(elapsed:Float)
	{
		
		FlxG.camera.focusOn(camFollow.getPosition());
		//txtOptionTitle.text = shittyNames[curSelected].toUpperCase();
		txtOptionTitle.text = "poop";
		txtOptionTitle.x = FlxG.width - (txtOptionTitle.width + 10);
		if (txtOptionTitle.text == '')
		{
			trace('NO FUCKING TEXT LMAO');
			txtOptionTitle.text = 'NO DESCRIPTION';
		}

		var upP = controls.LEFT_P;
		var downP = controls.RIGHT_P;
		var accepted = controls.ACCEPT;

		if (!alreadySelectedShit)
		{
			if (upP && canSelect && canSelectLeft)
				{
				changeSelection(-1);
				}
			if (downP && canSelect && canSelectRight)
				{
				changeSelection(1);
				}
		
				if (accepted && canSelect)
				{
					alreadySelectedShit = true;
					
					FlxG.sound.play('assets/sounds/confirmMenu.ogg');
					
					
					selectedChar = selectedCharPriv[curSelected];
					//BfSave.storySuffix = suffixArray[curSelected];
					trace(BfSave.bfMode);
					boyfriends.members[curSelected].animation.play('cheer');
					FlxFlicker.flicker(boyfriends.members[curSelected],0);
					
					new FlxTimer().start(0.7, function(tmr:FlxTimer)
						{
							if (storyMode){
							
								LoadingState.loadAndSwitchState(new PlayState(), true);
							}
							else
								LoadingState.loadAndSwitchState(new PlayState(), true);
						});
				}
		
				if (controls.BACK)
				{
					if (storyMode)
					FlxG.switchState(new MainMenuState());
					else
					FlxG.switchState(new MainMenuState());
				}
		}

		super.update(elapsed);
	}

	function changeSelection(change:Int = 0):Void
	{
		canSelectLeft = true;
		canSelectRight = true;
		canSelect = false;
		FlxG.sound.play('assets/sounds/scrollMenu.ogg', 0.4);

		curSelected += change;

		boyfriends.forEach(function(boyfriend:SelectSprite){
		boyfriend.alpha = 0.6;
        boyfriend.animation.paused = true;
		});
		
		
	
		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		switch (curSelected){
		case 0:
			canSelectLeft=false;
		case 2:
			canSelectRight=false;
		}
	

		//icons.forEach(function(icon:FlxSprite){
		//if (icon.ID == curSelected)
		//	icon.alpha = 1;
		//else
		//	icon.alpha = 0.2;
		//});

		boyfriends.members[curSelected].alpha = 1;
		boyfriends.members[curSelected].animation.play('idle');
		FlxTween.tween(camFollow, {x : boyfriends.members[curSelected].getMidpoint().x},1, {ease: FlxEase.smoothStepOut,	
			onComplete: function(twn:FlxTween){
				canSelect = true;
				trace('allow selection');
			}
		});
	
	
	
		

		charCheckLmao();
	}

	function charCheckLmao()
	{
	
		switch (menuItems[curSelected])
		{
			case "BOYFRIEND":
				FlxTween.color(menuBG,1,menuBG.color,bf1Color);
			
			case "PARAPPA":
				FlxTween.color(menuBG,1,menuBG.color,bf2Color);
				
			//case "BOYFRIENDTHIRD":
			//	FlxTween.color(menuBG,1,menuBG.color,bf3Color);

		}
	
	}
	
}