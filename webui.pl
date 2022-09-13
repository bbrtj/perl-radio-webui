use lib 'local/lib/perl5';

use Mojolicious::Lite -signatures;
use Mojo::Redis;

## TODO: grow this.

my $redis = Mojo::Redis->new('redis://localhost:6379');

get '/' => sub ($c) {
	$c->render(template => 'webui', current => 'todo');
};

get '/skip' => sub ($c) {
	$redis->pubsub->notify(radio => 'skip');
	$c->redirect_to('/');
};

app->start;

__DATA__

@@ webui.html.ep
<!DOCTYPE html>
<html>
	<head><title>Radio WebUI</title></head>
	<body>
		<p>Playing: <%= $current %></p>
		<a href="/skip"><button>skip</button></a>
	</body>
</html>

