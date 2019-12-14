require 'rails_helper'

RSpec.describe MessageMailer, type: :mailer do

	describe "contact the clinic" do
		fixtures :messages

		it "sends correct message to clinic" do
			@message = messages(:m1)
		 	MessageMailer.clinic_message(@message).deliver
		    ActionMailer::Base.deliveries.last.tap do |mail|
		        expect(mail.to).to eq(["#{@message.receiver_email}"])
		        expect(mail.subject).to eq("New Message from #{@message.sender_name}: #{@message.subject}")
		    end
		end

		it "sends correct confirmation to user" do
			@message = messages(:m1)
		  	MessageMailer.clinic_confirmation(@message).deliver
		  	ActionMailer::Base.deliveries.last.tap do |mail|
		        expect(mail.to).to eq(["#{@message.sender_email}"])
		        expect(mail.subject).to eq("Thank you for contacting Cbv X Stem")
		    end

		end
	end

	describe "send general notification" do
		fixtures :messages

		it "sends correct notification to patient" do
			@message = messages(:m2)
			MessageMailer.general_notification(@message, "medication", "created").deliver
		  	ActionMailer::Base.deliveries.last.tap do |mail|
		        expect(mail.to).to eq(["#{@message.receiver_email}"])
		        expect(mail.subject).to eq("A medication was created by #{@message.sender_name}")
		    end
		end
	end

	describe "send document notification" do
		fixtures :messages

		it "sends correct document notification" do
			@message = messages(:m1)
			MessageMailer.document_confirmation(@message).deliver
		  	ActionMailer::Base.deliveries.last.tap do |mail|
		        expect(mail.to).to eq(["#{@message.sender_email}"])
		        expect(mail.subject).to eq("Confirmation: a document uploaded")
		    end
		end
	end

	describe "send book notification" do
		fixtures :messages

		it "sends correct book notification" do
			@message = messages(:m1)
			MessageMailer.book_notification(@message).deliver
		  	ActionMailer::Base.deliveries.last.tap do |mail|
		        expect(mail.to).to eq(["#{@message.receiver_email}"])
		        expect(mail.subject).to eq("A slot was booked by #{@message.sender_name}")
		    end
		end
	end
end