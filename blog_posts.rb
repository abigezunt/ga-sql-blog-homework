require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'pry'

configure do 
	CONN = PG.connect(dbname: 'blog', host: 'localhost')
end


def query(sql)
	CONN.exec(sql)
end

# binding.pry

entry_1 = {"subject" => "Moby Dick", "contents" => "From the vibrating line extending the entire length of the upper part of the boat, and from its now being more tight than a harpstring, you would have thought the craft had two keels; one cleaving the water, the other the air; as the boat churned on through both opposing elements at once. A continual cascade played at the bows; a ceaseless whirling eddy in her wake; and, at the slightest motion from within, even but of a little finger, the vibrating, cracking craft canted over her spasmodic gunwale into the sea. Thus they rushed; each man with might and main clinging to his seat, to prevent being tossed to the foam; and the tall form of Tashtego at the steering oar crouching almost double, in order to bring down his centre of gravity. Whole Atlantics and Pacifics seemed passed as they shot on their way, till at length the whale somewhat slackened his flight. 'Haul in; haul in!' cried Stubb to the bowsman! and, facing round towards the whale, all hands began pulling the boat up to him, while yet the boat was being towed on.", "timestamp" => "2013/08/16"}
entry_2 = {"subject" => "Around the World in 80 Days", "contents" => "He did not finish his sentence; for a terrific hubbub now arose on the terrace behind the flight of steps where they stood, and there were frantic shouts of, 'Hurrah for Mandiboy!  Hip, hip, hurrah!' It was a band of voters coming to the rescue of their allies, and taking the Camerfield forces in flank.  Mr. Fogg, Aouda, and Fix found themselves between two fires; it was too late to escape.  The torrent of men, armed with loaded canes and sticks, was irresistible.  Phileas Fogg and Fix were roughly hustled in their attempts to protect their fair companion; the former, as cool as ever, tried to defend himself with the weapons which nature has placed at the end of every Englishman's arm, but in vain.  A big brawny fellow with a red beard, flushed face, and broad shoulders, who seemed to be the chief of the band, raised his clenched fist to strike Mr. Fogg, whom he would have given a crushing blow, had not Fix rushed in and received it in", "timestamp" => "2011/03/21"}
entry_3 = {"subject" => "The Scarlet Plague", "contents" => "On his back was a quiverful of arrows. From a sheath hanging about his  neck on a thong, projected the battered handle of a hunting knife. He  was as brown as a berry, and walked softly, with almost a catlike tread.  In marked contrast with his sunburned skin were his eyes; blue, deep  blue, but keen and sharp as a pair of gimlets. They seemed to bore into  aft about him in a way that was habitual. As he went along he smelled  things, as well, his distended, quivering nostrils carrying to his brain  an endless series of messages from the outside world. Also, his hearing  was acute, and had been so trained that it operated automatically.  Without conscious effort, he heard all the slight sounds in the apparent  quiet; heard, and differentiated, and classified these sounds; whether  they were of the wind rustling the leaves, of the humming of bees and  gnats, of the distant rumble of the sea that drifted to him only in  lulls, or of the gopher, just under his foot, shoving a pouchful of  earth into the entrance of his hole. Suddenly he became alertly tense. Sound, sight, and odor had given him  a simultaneous warning. His hand went back to the old man, touching  him, and the pair stood still. Ahead, at one side of the top of the  embankment, arose a crackling sound, and the boy's gaze", "timestamp" => "2008/4/07"}
entry_4 = {"subject" => "The Wizard of Oz", "contents" => "They came from all directions, and there were thousands of them: big mice and little mice and middle-sized mice; and each one brought a piece of string in his mouth.  It was about this time that Dorothy woke from her long sleep and opened her eyes.  She was greatly astonished to find herself lying upon the grass, with thousands of mice standing around and looking at her timidly.  But the Scarecrow told her about everything, and turning to the dignified little Mouse, he said: 'Permit me to introduce to you her Majesty, the Queen.' Dorothy nodded gravely and the Queen made a curtsy, after which she became quite friendly with the little girl. The Scarecrow and the Woodman now began to fasten the mice to the truck, using the strings they had brought.  One end of a string was tied around the neck of each mouse and the other end to the truck.  Of course the truck was a thousand times bigger than any of the", "timestamp" => "2007/11/13"}
entry_5 = {"subject" => "Alice in Wonderland", "contents" => "'I haven't the least idea what you're talking about,' said Alice. 'I've tried the roots of trees, and I've tried banks, and I've tried  hedges,' the Pigeon went on, without attending to her; 'but those  serpents! There's no pleasing them!' Alice was more and more puzzled, but she thought there was no use in  saying anything more till the Pigeon had finished. 'As if it wasn't trouble enough hatching the eggs,' said the Pigeon;  'but I must be on the look-out for serpents night and day! Why, I  haven't had a wink of sleep these three weeks!' 'I'm very sorry you've been annoyed,' said Alice, who was beginning to  see its meaning. 'And just as I'd taken the highest tree in the wood,' continued the  Pigeon, raising its voice to a shriek, 'and just as I was thinking I  should be free of them at last, they must needs come wriggling down from  the sky! Ugh, Serpent!' 'But I'm NOT a serpent, I tell you!' said Alice. 'I'm a; I'm a; ' 'Well! WHAT are you?' said the Pigeon. 'I can see you're trying to ", "timestamp" => "2006/12/20"}
blog_posts = [entry_1, entry_2, entry_3, entry_4, entry_5]

blog_posts.each do |post|
	query("INSERT INTO blog (subject, contents, created_at) VALUES ('#{post['subject']}', '#{post['contents']}', '#{post['timestamp']}')")
end


get '/blog' do
	@result = query("SELECT title, timestamp FROM blog_posts ORDER BY timestamp DESC")
	erb :blog
end
