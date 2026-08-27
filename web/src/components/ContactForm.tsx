import { useState, type FormEvent } from 'react';

const STRAPI_URL = import.meta.env.PUBLIC_STRAPI_URL ?? 'http://localhost:1337';

type Status = 'idle' | 'submitting' | 'success' | 'error';

export default function ContactForm() {
  const [status, setStatus] = useState<Status>('idle');
  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setStatus('submitting');
    setErrorMessage(null);

    const form = event.currentTarget;
    const formData = new FormData(form);
    const payload = {
      data: {
        name: formData.get('name'),
        email: formData.get('email'),
        company: formData.get('company'),
        message: formData.get('message'),
      },
    };

    try {
      const res = await fetch(`${STRAPI_URL}/api/contact-submissions`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });

      if (!res.ok) {
        throw new Error(`Request failed with status ${res.status}`);
      }

      setStatus('success');
      form.reset();
    } catch (err) {
      setStatus('error');
      setErrorMessage('No pudimos enviar tu solicitud. Intenta de nuevo o escríbenos por WhatsApp.');
    }
  }

  if (status === 'success') {
    return (
      <div className="card" style={{ padding: '30px' }}>
        <p style={{ fontSize: '16px', fontWeight: 600, color: 'var(--ink)' }}>
          ¡Solicitud enviada!
        </p>
        <p style={{ fontSize: '14.5px', color: 'var(--ink-soft)', marginTop: '8px' }}>
          Uno de nuestros representantes se pondrá en contacto contigo de inmediato, en los
          próximos 5 minutos.
        </p>
      </div>
    );
  }

  return (
    <form className="card" style={{ display: 'flex', flexDirection: 'column', padding: '30px' }} onSubmit={handleSubmit}>
      <div className="field">
        <label htmlFor="name">Nombre</label>
        <input id="name" name="name" type="text" placeholder="Tu nombre completo" required />
      </div>
      <div className="field">
        <label htmlFor="email">Email</label>
        <input id="email" name="email" type="email" placeholder="tu@empresa.com" required />
      </div>
      <div className="field">
        <label htmlFor="company">Empresa</label>
        <input id="company" name="company" type="text" placeholder="Nombre de tu empresa" />
      </div>
      <div className="field">
        <label htmlFor="message">Mensaje</label>
        <textarea
          id="message"
          name="message"
          rows={4}
          placeholder="Cuéntanos qué estás buscando resolver"
          required
        />
      </div>
      {status === 'error' && errorMessage && (
        <p style={{ fontSize: '13px', color: 'var(--coral)', marginBottom: '12px' }}>{errorMessage}</p>
      )}
      <button
        type="submit"
        className="btn btn-primary"
        style={{ justifyContent: 'center', marginTop: '6px' }}
        disabled={status === 'submitting'}
      >
        {status === 'submitting' ? 'Enviando…' : 'Enviar solicitud'}
      </button>
    </form>
  );
}
