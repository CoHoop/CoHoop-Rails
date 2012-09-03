require_relative '../../lib/tag_extractor/tag_extractor.rb'

describe TagExtractor do
  describe 'for a String' do
    let(:sharp_tags) { %w(#tag1 #tag2 #tag3 #foo-bar #foo #bar) }
    let(:at_tags) { %w(@share) }
    let(:source) { "Le petit #{sharp_tags[0]}, #{sharp_tags[1]}, #{sharp_tags[2]} !#1 !## #Per #{sharp_tags[3]} #{sharp_tags[4]} #{sharp_tags[5]}, #1we #{at_tags[0]}" }
    describe TagExtractor::StringExtractor do
      let(:content) { TagExtractor::StringExtractor.new(source) }
      it 'should have a source of type string' do
        content.source.should be_kind_of String
      end

      describe '#extract_with_separator method' do
        specify 'if no tag separator is set' do
          ->{ content.extract_with_separator }.should raise_error(TagExtractor::TagSeparatorError)
        end

        specify 'if a tag separator is set' do
          TagExtractor.tag_separator = '#'
          # Extracts the first character from the first tag returned
          content.extract_with_separator.first[0].should == '#'
        end

        specify 'if a tag separator is explicitly send' do
          content.extract_with_separator('@').first[0].should == '@'
        end

        it 'should return all the tags' do
          TagExtractor.tag_separator = '#'
          content.extract_with_separator.should == sharp_tags
          content.extract_with_separator('@').should == at_tags
        end
      end # extract_with_separator method

      describe '#extract method' do
        it 'should return all the tags' do
          TagExtractor.tag_separator = '#'
          content.extract.should == sharp_tags.collect { |t| t.slice!(0); t }
          TagExtractor.tag_separator = '@'
          content.extract.should == at_tags.collect { |t| t.slice!(0); t }
        end
      end # extract
    end # StringExtractor

    describe 'String#extract_tags' do
      it 'should add extractor methods to class String' do
        ->{ "string".extract_tags }.should_not raise_error(NoMethodError)
      end
      it 'should extract tags from the string' do
        source.extract_tags('#').should == sharp_tags.collect { |t| t.slice!(0); t }
      end
      it 'should return an empty array if no tags were found' do
        "string".extract_tags.should == []
      end
    end
  end # for a String
end
