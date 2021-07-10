package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

class DisclaimerStateTwo extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";
	public static var currChanges:String = "dk";
	
	private var bgColors:Array<String> = [
		'#314d7f',
		'#4e7093',
		'#70526e',
		'#594465'
	];
	private var colorRotation:Int = 1;

	override function create()
	{
		super.create();
		var bg = new FlxSprite().loadGraphic(Paths.image('gameSelect/bg'));
		add(bg);
		

		
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"DISCLAIMER:\n\n"
			+ "\nOnly Weeks 1-3 and Tutorial have Parappa vocals so far!"
			+ "\nMore will be added soon.\n\n",
			32);
		
		txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter();
		add(txt);
		
		FlxTween.color(bg, 2, bg.color, FlxColor.fromString(bgColors[colorRotation]));
		
	}

	override function update(elapsed:Float)
	{
		
		if (controls.BACK || controls.ACCEPT)
		{
			leftState = true;
			FlxG.switchState(new FreeplayState());
		}
		super.update(elapsed);
	}
}
