namespace Flowframes.Data.Streams
{
    public class AudioStream : Stream
    {
        public int Kbits { get; }
        public int SampleRate { get; }
        public int Channels { get; }
        public string Layout { get; }

        public AudioStream(string language, string title, string codec, string codecLong, int kbits, int sampleRate, int channels, string layout)
        {
            base.Type = StreamType.Audio;
            Language = language;
            Title = title;
            Codec = codec;
            CodecLong = codecLong;
            Kbits = kbits;
            SampleRate = sampleRate;
            Channels = channels;
            Layout = layout;
        }

        public override string ToString()
        {
            string title = string.IsNullOrWhiteSpace(Title) ? " - Untitled" : $" - '{Title}'";
            string bitrate = Kbits > 0 ? $" - Kbps: {Kbits}" : "";
            string sampleRate = SampleRate > 0 ? $" - Rate: {(SampleRate / 1000).ToString("0.0#")} kHz" : "";
            string layout = Layout.IsNotEmpty() ? $" [{Layout.Replace("(", " ").Replace(")", " ").Trim()}]" : "";
            return $"{base.ToString()} - Language: {LanguageFmt}{title}{bitrate}{sampleRate} - Channels: {Channels}{layout}";
        }
    }
}
